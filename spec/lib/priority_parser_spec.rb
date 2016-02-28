#encoding: UTF-8

require 'spec_helper'
require 'csv'

describe PriorityParser do
  describe ".process" do
    let(:pickups_from_file) { CSV.read("spec/fixtures/isuf.txt", col_sep: "\t", encoding: "Windows-1255")[1..-1] }

    it "process pickups into the database" do
      PriorityParser.process(pickups_from_file)

      pickups = [Pickup.find_by_priority_id("108211"), Pickup.find_by_priority_id("108212")]
      expect(pickups.first).to have_attributes(
                                   status: "נשלח מייל",
                                   date: Date.strptime("15/2/16", "%d/%m/%y"),
                                   supplier: Supplier.find_by_priority_id("FS000047"),
                                   user: User.find_by_priority_id("VOL10000772")
                               )

      expect(pickups.first.user).to have_attributes(
                                        email: "oferei@014.net.il",
                                        name: "עופר עילם",
                                        phone: "0523613666",
                                    )

      expect(pickups.first.supplier).to have_attributes(name: "מרכז עזריאלי")

      expect(pickups.second).to have_attributes(
                                   status: "נשלח מייל",
                                   date: Date.strptime("15/2/16", "%d/%m/%y"),
                                   supplier: Supplier.find_by_priority_id("FS000394"),
                                   user: User.find_by_priority_id("VOL10001862")
                               )

      expect(pickups.second.user).to have_attributes(
                                        email: "saharezri@gmail.com",
                                        name: "סהר (שמחה) עזרי",
                                        phone: "054-4401372",
                                    )

      expect(pickups.first.supplier).to have_attributes(name: "מרכז עזריאלי")

      expect(pickups.first.supplier.suppliers[0]).to have_attributes(name: "מרקש אקספרס-עזריאלי")
      expect(pickups.first.supplier.suppliers[1]).to have_attributes(name: "פיצה עגבניה עזריאלי")
      expect(pickups.first.supplier.suppliers[2]).to have_attributes(name: "כרמליס בייגלס עזריאלי")
      expect(pickups.first.supplier.suppliers[3]).to have_attributes(name: "רוזה אקספרס עזריאלי")
      expect(pickups.first.supplier.suppliers[4]).to have_attributes(name: "רולדין עזריאלי")
      expect(pickups.first.supplier.suppliers[5]).to have_attributes(name: "שינטו בר יפני עזריאלי")
      expect(pickups.first.supplier.suppliers[6]).to have_attributes(name: "טוסטר - עזריאלי")
      expect(pickups.first.supplier.suppliers[7]).to have_attributes(name: "בורגרס בר עזריאלי")
      expect(pickups.first.supplier.suppliers[8]).to have_attributes(name: "קריספי שניצל עזריאלי")
      expect(pickups.first.supplier.suppliers[9]).to have_attributes(name: "פיקנסין עזריאלי")
      expect(pickups.first.supplier.suppliers[10]).to have_attributes(name: "קפה הלל עזריאלי")
    end

    it "overrides existing pickups" do
      PriorityParser.process(pickups_from_file)

      pickup = Pickup.find_by_priority_id("108211")
      pickup.status = "This should be changed by the second process"
      pickup.save!

      PriorityParser.process(pickups_from_file)

      expect(pickup.reload.status).to eq "נשלח מייל"
    end
  end
end
