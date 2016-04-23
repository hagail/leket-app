# == Schema Information
#
# Table name: pickup_reasons
#
#  id          :integer          not null, primary key
#  priority_id :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PickupReason < ActiveRecord::Base



def self.process_from_file(filepath)


  file_input = CSV.read(filepath, col_sep: "\t")[1..-1]
  reasons = file_input.flatten.map{|x| x.split(",")}

  reasons.each do |reason|
    PickupReason.create(priority_id: reason[0], name: reason[1])
  end

end

end
