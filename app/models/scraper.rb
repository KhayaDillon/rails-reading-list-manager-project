require 'pry'

class Scraper

  def self.get_book_list
    Nokogiri::HTML(open("https://www.barnesandnoble.com/b/books/_/N-1fZ29Z8q8"))
  end

  def self.scrape_barnesnnoble_book_list
    homepage = "https://www.barnesandnoble.com"
    get_book_list.css('div.pb-m.mt-m.bd-bottom-disabled-gray.record').collect do |book_listing|
      {title: book_listing.css('h3.product-info-title a').text.strip,
      author: book_listing.css('div.product-shelf-author.contributors a:first-child').text.strip}
    end
  end

  def self.create_and_collect_books
    scraper = self.scrape_barnesnnoble_book_list
    scraper.each do |book_hash|
      Book.create(book_hash)
      #instance = Book.new
      #instance.title = hash[:Title]
      #instance.author = hash[:Author]
      #Book.all << instance
    end
  end

end