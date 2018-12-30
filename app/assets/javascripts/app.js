
function addListeners() {
	const bookCoverDivs = document.querySelectorAll(".book-cover") 
	
	bookCoverDivs.forEach( book => {
		book.addEventListener("mouseenter", presentBookInfo)
		book.addEventListener("mouseleave", hideBookInfo)
		book.addEventListener("click", selectBook)
	})
}

function selectBook() {
	const book = this
	const bookCoverDivs = document.querySelectorAll(".book-cover") 
	const body = document.querySelector("body")
	
	presentBookInfo.call(book)
	
	bookCoverDivs.forEach( div => div.removeEventListener("mouseenter", presentBookInfo))
	bookCoverDivs.forEach( div => div.removeEventListener("mouseleave", hideBookInfo))
}

function presentBookInfo() {
	bookInfo = this.nextElementSibling
	bookInfo.classList.remove("hidden")
}

function hideBookInfo() {
	bookInfo = this.nextElementSibling
	bookInfo.classList.add("hidden")
}
 
// function selectBook(book) {
	// document.querySelectorAll(".book-cover").forEach( div => div.removeEventListener("mouseenter", presentBookInfo))
// }
// 
// function mouseLeaveAction(book, action) {
	// if (action === "hover") {
		// book.addEventListener("mouseleave", function() {
			// hideBookInfo(book)
		// })	
	// } 
// }
