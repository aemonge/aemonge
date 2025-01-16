// Function to show an article
function showArticle(url) {
	document.getElementById("articleWrapperId").style.display = "block";
	document.getElementById("render").style.display = "none";
	document.getElementById("home-content").style.display = "none";
}

// Function to show home content
function showHome() {
	document.getElementById("home-content").style.display = "block";
	document.getElementById("articleWrapperId").style.display = "none";
	document.getElementById("render").style.display = "none";
}

document.addEventListener("DOMContentLoaded", () => {
	const resumeLink = document.querySelector('a[href="#resume"]');
	const articlesLink = document.querySelector('a[href="#articles"]');

	// Check if the links are not null
	if (resumeLink && articlesLink) {
		// Add event listeners to the links
		articlesLink.addEventListener("click", showArticles);
	}

	// Add click event to open the PDF in a new tab
	document.querySelector("#render").addEventListener("click", () => {
		const link = document.createElement("a");
		document.body.appendChild(link);
		link.target = "_blank";
		link.href = "python-tech-lead_andres-monge.pdf";
		link.click();
		document.body.removeChild(link); // Clean up
	});

	showArticles();
});
