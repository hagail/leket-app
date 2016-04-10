require 'dropbox_sdk'
require 'csv'
require_relative '../../lib/priority_parser'


module DropboxFetcher
  def self.client
    # @client ||= DropboxClient.new(ENV['DROPBOX_ACCESS_TOKEN'])
    dbsession = DropboxSession.deserialize(AppSettings.dropbox_admin_session)
    @client ||= DropboxClient.new(dbsession,:app_folder)
  end

  def self.get_file(path)
    client.get_file(path)
  end

  def self.write_file(file:, path:)
     client.put_file(path, file)
  end

  def self.grab_pickups(isuf_file='/isuf.txt')
    file = get_file(isuf_file)
    decoded_file = file.force_encoding("cp1255").encode("utf-8", undef: :replace)
    File.open('isuf_tmp.txt', 'w:utf-8') {|f| f.write decoded_file }

    pickups_from_file = CSV.read("isuf_tmp.txt", col_sep: "\t", encoding: "utf-8")[1..-1]
    PriorityParser.process(pickups_from_file)
  end

  def self.write_report
    file = PickupReport.report_file_name
    PickupReport.create_approved_csv
    self.write_file(path: "/results/#{Date.today.strftime}.txt", file: open(file))
  end
end
