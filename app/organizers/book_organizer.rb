class BookOrganizer

  def self.take_out(book)
    if book.shelf_name == "Finished Reading"
      book.update(status: "Finished", current_page: book.page_count)
    else
      book.update(status: "Plan to Read")
    end
    book.save
    book.current_location = book
  end

  def self.status_change_from_fin_shelf(book_info, message)
    #When book is on Finished shelf and only the status gets changed
    if book_info[:updated].shelf_name == "Finished Reading" && book_info[:updated].shelf_name == book_info[:old].shelf_name && book_info[:updated].status != "Finished" && book_info[:updated].status != "Dropped" 
      #If current page has not been appropriately lowered, don't change status
      if book_info[:updated].current_page == book_info[:updated].page_count
        book_info[:updated].status = "Finished" 
        message[:alert] = "Your book's status is no longer finished? Then your current page can't be the last page. Please update your current page accordingly."
      #Move to Reading shelf if shelf is not given, but status and current page has been adjusted appropriately
      else 
        book_info[:updated].set_shelf(book_info[:owner], "Reading")
      end
    end
  end

  def self.shelf_set_to_read_with_fin_status(book_info, message)
    #When the status has been left to Finished but the shelf has been changed to Reading
    if book_info[:updated].status == "Finished" && book_info[:updated].status == book_info[:old].status && book_info[:updated].shelf_name == "Reading"
      book_info[:updated].set_shelf(book_info[:owner], book_info[:old].shelf_name)
      message[:alert] = "Books you have finished can't be put on your Reading Shelf. Please update your status and current page."
    end
  end

  def self.shelf_set_to_fin(book_info, message)
    #When user changes the shelf to Finished
    if book_info[:updated].shelf_name == "Finished Reading" && book_info[:updated].shelf_name != book_info[:old].shelf_name
      #If user has not altered book status 
      if book_info[:updated].status == book_info[:old].status 
        book_info[:updated].status = "Finished"  
      #If the user had also altered the status, and it's not Finished
      elsif book_info[:updated].status != "Finished" && book_info[:updated].status != "Dropped"
        message[:alert] = "You can't put a book that is not finished on your Finished Reading Shelf. Please change the book's status."
        book_info[:updated].set_shelf(book_info[:owner], book_info[:old].shelf_name)
      end
    end
  end

end