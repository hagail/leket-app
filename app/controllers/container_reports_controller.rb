# == Schema Information
#
# Table name: container_reports
#
#  id                  :integer          not null, primary key
#  quantity            :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  container_id        :integer
#  food_type_report_id :integer
#

class ContainerReportsController < ApplicationController

  def update
    @container_report = ContainerReport.find params[:id]
    @container_report.update_attributes container_reports_params
    respond_with_bip(@container_report)
  end

  private

  def container_reports_params
    params.require(:container_report).permit(:quantity)
  end
end
