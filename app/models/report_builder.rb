module ReportBuilder
  def self.build_pickup_report(pickup)
    pickup_report = PickupReport.new(pickup: pickup)
    if pickup.supplier.suppliers.any?
      pickup.supplier.suppliers.each do |supplier|
        build_supplier_report(pickup_report, supplier)
      end
    else
      build_supplier_report(pickup_report, pickup.supplier)
    end

    pickup_report.tap { |report| report.save! }
  end

  private

  def self.build_supplier_report(pickup_report, supplier)
    supplier_report = pickup_report.supplier_reports.build(supplier: supplier)
    build_food_type_reports(supplier_report)
  end

  def self.build_food_type_reports(supplier_report)

    FoodType.all.each do |food_type|
      food_type_report = supplier_report.food_type_reports.build(food_type: food_type)
      build_container_reports(food_type_report)
    end
  end

  def self.build_container_reports(food_type_report)
    food_type_report.food_type.containers.each do |container|
      food_type_report.container_reports.build(container: container)
    end
  end
end