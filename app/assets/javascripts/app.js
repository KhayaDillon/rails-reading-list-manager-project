// const bookInfo = document.getElementById("book-info")

function presentBookInfo(book) {
	bookInfo = book.nextElementSibling
	bookInfo.classList.remove("hidden")
}

function hideBookInfo(book) {
	bookInfo = book.nextElementSibling
	bookInfo.classList.add("hidden")
}
