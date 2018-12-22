// const bookInfo = document.getElementById("book-info")

function presentBookInfo(bookDiv) {
	bookInfo = bookDiv.childNodes[3]
	bookInfo.classList.remove("hidden")
}

function hideBookInfo(bookDiv) {
	bookInfo = bookDiv.childNodes[3]
	bookInfo.classList.add("hidden")
}
