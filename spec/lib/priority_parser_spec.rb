#encoding: UTF-8

require 'spec_helper'
require 'csv'

describe PriorityParser do
  describe ".process" do
    let(:pickups_from_file) { CSV.read("spec/fixtures/isuf.txt", col_sep: "\t", encoding: "Windows-1255")[1..-1] }

    it "process pickups into the database" do
      PriorityParser.process(pickups_from_file)

      pickups = [Pickup.find_by_priority_id("108618"), Pickup.find_by_priority_id("111540")]

      expect(pickups.first).to have_attributes(
                                   status: "נשלח מייל",
                                   date: Date.strptime("01/04/15", "%d/%m/%y"),
                                   supplier: Supplier.find_by_priority_id("FS000394"),
                                   user: User.find_by_priority_id("VOL10001991")
                               )

      expect(pickups.first.user).to have_attributes(
                                        email: "eliyosef15@gmail.com",
                                        name: "אליהו יוסף",
                                        phone: "054-5842171",
                                    )

      expect(pickups.first.supplier).to have_attributes(name: "אייל מאפים טובים")

      expect(pickups.second).to have_attributes(
                                   status: "נשלח מייל",
                                   date: Date.strptime("31/03/15", "%d/%m/%y"),
                                   supplier: Supplier.find_by_priority_id("FS000119"),
                                   user: User.find_by_priority_id("VOL10000240")
                               )

      expect(pickups.second.user).to have_attributes(
                                        email: "rkimelman@wbais.net",
                                        name: "רבקה קימלמן",
                                        phone: "0507635693",
                                    )

      expect(pickups.second.supplier).to have_attributes(name: "קניון שבעת הכוכבים")

      expect(pickups.second.supplier.suppliers[0]).to have_attributes(name: "ארקפה- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[1]).to have_attributes(name: "צ'יינה טאון- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[2]).to have_attributes(name: "רולדין- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[3]).to have_attributes(name: "אילנ'ס- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[4]).to have_attributes(name: "קפה גרג- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[5]).to have_attributes(name: "אוניון- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[6]).to have_attributes(name: "סטריט מיט- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[7]).to have_attributes(name: "ארומה- סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[8]).to have_attributes(name: "שוק אוכל קניום שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[9]).to have_attributes(name: "השניצליה - סניף שבעת הכוכבים")
      expect(pickups.second.supplier.suppliers[10]).to have_attributes(name: "פיצה פינו -קניון שבעת הכוכבים")
    end

    it "overrides existing pickups" do
      PriorityParser.process(pickups_from_file)

      pickup = Pickup.find_by_priority_id("108618")
      pickup.status = "This should be changed by the second process"
      pickup.save!

      PriorityParser.process(pickups_from_file)

      expect(pickup.reload.status).to eq "נשלח מייל"
    end
  end
end
