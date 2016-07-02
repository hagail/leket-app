class SupplierReportsController < ApplicationController
  http_basic_authenticate_with name: 'test', password: 'test'

  def update
    @sr = SupplierReport.find params[:id]
    respond_to do |format|
      if params[:supplier_report][:pickup_reason_id].present? && @sr.update_attributes(sr_params)
        format.json { respond_with_bip(@sr) }
      else
        format.json { respond_with_bip(@sr) }
      end
    end
  end

  private

  def sr_params
    params.require(:supplier_report).permit(:pickup_reason_id)
  end
end
