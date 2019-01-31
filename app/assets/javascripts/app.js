
document.addEventListener("turbolinks:load", function() {
	addBookPadding()
	addListeners()
})

function addListeners() {
	const bookCoverImgs = document.querySelectorAll(".book-cover-img") 
	
	bookCoverImgs.forEach( book => {
		book.addEventListener("mouseenter", presentBookInfo)
		book.addEventListener("mouseleave", hideBookInfo)
		book.addEventListener("click", selectBook)
	})
}

function addBookPadding() {
	const bookCoverImgs = document.querySelectorAll(".book-cover-img")
	 
	bookCoverImgs.forEach( cover => {
		if (cover.clientHeight < 193) {
			let padding = 193 - cover.clientHeight
			cover.style.paddingTop = `${padding}px`
		} else if (cover.clientHeight > 193) {
			cover.style.height = "193px"
		} 
		
		if (window.getComputedStyle(cover).paddingTop == "193px") {
			cover.style.paddingTop = "0px"
		}
		
		cover.style.paddingBottom = "16.5px"
	})
}

function presentBookInfo() {
	bookInfo = document.getElementById("book-" + this.id)
	bookInfo.classList.remove("hidden")
}

function hideBookInfo() {
	bookInfo = document.getElementById("book-" + this.id)
	bookInfo.classList.add("hidden")
}

function selectBook() {
	const book = this
	const bookCoverImgs = document.querySelectorAll(".book-cover-img") 
	const downArrow = document.querySelectorAll(".exit-x") 
	const body = document.querySelector("body")
	
	presentBookInfo.call(book)
	
	bookCoverImgs.forEach( div => div.removeEventListener("mouseenter", presentBookInfo))
	bookCoverImgs.forEach( div => div.removeEventListener("mouseleave", hideBookInfo))
	downArrow.forEach( arrow => arrow.addEventListener("click", function() {
		hideBookInfo.call(book)
		addListeners()		
	}))	
}
 