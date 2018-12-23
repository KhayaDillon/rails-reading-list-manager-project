//const bookCoverDivs = document.querySelectorAll(".book-cover")

function presentBookInfo(book) {
	bookInfo = book.nextElementSibling
	bookInfo.classList.remove("hidden")
	mouseLeaveAction(book, "hover")
}

function hideBookInfo(book) {
	bookInfo = book.nextElementSibling
	bookInfo.classList.add("hidden")
}

function selectBook(book) {
	presentBookInfo(book)
	mouseLeaveAction(book, "selection")
}

function mouseLeaveAction(book, action) {
	if (action === "hover") {
		book.addEventListener("mouseleave", function() {
			console.log("hit")
			hideBookInfo(book)
		})	
	} 
}
