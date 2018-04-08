require 'rails_helper'

describe Scraper do
  describe ".scrape_usa_book_list" do
    it "scrapes book listing from site and creates hash of book details" do
      Scraper.scrape_usa_book_list
      expect(Scraper.scrape_usa_book_list).not_to eql([])
    end
  end
end