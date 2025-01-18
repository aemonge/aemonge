// Function to show the resume
function showResume() {
	if (articlesLink && resumeLink) {
		articlesLink.classList.remove("active");
		resumeLink.classList.add("active");
	}
	document.getElementById("render").style.display = "block";
	document.getElementById("articleWrapper").style.display = "none";
	renderPDF(
		"python-tech-lead_andres-monge.pdf",
		document.querySelector("#render"),
	);
}

// Function to show the articles
function showArticles() {
	if (articlesLink && resumeLink) {
		articlesLink.classList.add("active");
		resumeLink.classList.remove("active");
	}
	document.getElementById("render").style.display = "none";
	document.getElementById("articleWrapper").style.display = "block";
	document.getElementById("articleWrapper").src = "articles/index.html";
}

function renderPage(page) {
	let viewport = page.getViewport({ scale: 0.5 });
	const DPI = 72;
	const PRINT_OUTPUT_SCALE = DPI / 72;
	const scale = canvasContainer.clientWidth / viewport.width;
	const canvas = document.createElement("canvas");

	const ctx = canvas.getContext("2d");
	viewport = page.getViewport({ scale });

	canvas.width = Math.floor(viewport.width * PRINT_OUTPUT_SCALE);
	canvas.height = Math.floor(viewport.height * PRINT_OUTPUT_SCALE);
	canvas.style.width = "100%";

	canvas.style.transform = "scale(1,1)";
	canvas.style.transformOrigin = "0% 0%";

	const canvasWrapper = document.createElement("div");

	canvasWrapper.style.width = "100%";
	canvasWrapper.style.height = "100%";

	canvasWrapper.appendChild(canvas);

	const renderContext = {
		canvasContext: ctx,
		viewport,
	};

	canvasContainer.appendChild(canvasWrapper);

	page.render(renderContext);
}

function renderPages(pdfDoc) {
	for (let num = 1; num <= pdfDoc.numPages; num += 1)
		pdfDoc.getPage(num).then(renderPage);
}

// PDF rendering logic
function renderPDF(url, canvasContainer) {
	pdfjsLib.disableWorker = true;
	pdfjsLib.getDocument(url).promise.then(renderPages, (error) => {
		console.error("Error loading PDF:", error);
	});
}

document.addEventListener("DOMContentLoaded", () => {
	// Include the PDF.js library
	const pdfjsLib = window["pdfjs-dist/build/pdf"];

	const resumeLink = document.querySelector('a[href="#resume"]');
	const articlesLink = document.querySelector('a[href="#articles"]');

	// Check if the links are not null
	if (resumeLink && articlesLink) {
		// Add event listeners to the links
		resumeLink.addEventListener("click", showResume);
		articlesLink.addEventListener("click", showArticles);
	}

	// Add click event to open the PDF in a new tab
	document.querySelector("#render").addEventListener("click", () => {
		const link = document.createElement("a");
		document.body.appendChild(link);
		link.target = "_blank";
		link.href = "python-tech-lead_andres-monge.pdf";
		link.click();
	});

	showArticles();
});
