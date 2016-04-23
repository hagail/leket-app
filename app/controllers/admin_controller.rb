require 'dropbox_sdk'

class AdminController < ApplicationController
  http_basic_authenticate_with name: 'test', password: 'test'

  def summary
    # need pickup report with supplier report with food type and container report for each user
    approved = params[:approved] == 'yes' ? true : false
    @reports = PickupReport.includes(supplier_reports: :supplier, food_type_reports: :food_type, container_reports: :container).joins(:pickup).uniq
    @reports = if approved
                 @reports.merge(Pickup.approved)
               else
                 @reports.merge(Pickup.not_approved)
               end

    @dropbox_email = AppSettings.dropbox_email

    render 'pickup_reports/summary'
  end

  def approve
    report = PickupReport.find(params[:id])
    pickup = report.pickup
    pickup.approve!
    head :ok
  end

  def unapprove
    report = PickupReport.find(params[:id])
    pickup = report.pickup
    pickup.unapprove!
    head :ok
  end

  def dropbox_authorization
    dbsession = DropboxSession.new(ENV['DROPBOX_APP_KEY'], ENV['DROPBOX_APP_SECRET'])
    # serialize and save this DropboxSession
    session[:dropbox_session] = dbsession.serialize
    # pass to get_authorize_url a callback url that will return the user here
    redirect_to dbsession.get_authorize_url url_for(action: 'dropbox_callback')
  end

  def dropbox_callback
    dbsession = DropboxSession.deserialize(session[:dropbox_session])
    dbsession.get_access_token # we've been authorized, so now request an access_token
    client = DropboxClient.new(dbsession, :app_folder)
    AppSettings.dropbox_email = client.account_info['email']
    AppSettings.dropbox_admin_session = dbsession.serialize
    session.delete :dropbox_session
    flash[:success] = 'You have successfully authorized with dropbox.'
    redirect_to pickups_summary_path
  end
end
