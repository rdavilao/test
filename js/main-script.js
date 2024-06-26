document.addEventListener("DOMContentLoaded", function () {
  var clickableContainers = document.querySelectorAll(".service");

  clickableContainers.forEach(function (container) {
    container.addEventListener("click", function () {
      var url = container.getAttribute("data-url");
      if (url) {
        window.location.href = url;
      }
    });
  });
});

document.addEventListener("DOMContentLoaded", function () {
  var clickableContainers = document.querySelectorAll(".book-now-btn");

  clickableContainers.forEach(function (container) {
    container.addEventListener("click", function () {
      var url = container.getAttribute("data-url");
      if (url) {
        window.location.href = url;
      }
    });
  });
});

document.addEventListener("DOMContentLoaded", function () {
  var clickableContainers = document.querySelectorAll(".book-a-service");

  clickableContainers.forEach(function (container) {
    container.addEventListener("click", function () {
      var url = container.getAttribute("data-url");
      if (url) {
        window.location.href = url;
      }
    });
  });
});

document.addEventListener("DOMContentLoaded", function () {
  var toggleButton = document.getElementById("toggleButton-Service");
  var hiddenDiv = document.getElementById("hiddenService-menu");

  toggleButton.addEventListener("mouseenter", function () {
    hiddenDiv.classList.remove("hidden");
    hiddenDiv.classList.add("visible");
  });

  toggleButton.addEventListener("mouseleave", function () {
    hiddenDiv.classList.remove("visible");
    hiddenDiv.classList.add("hidden");
  });

  hiddenDiv.addEventListener("mouseenter", function () {
    hiddenDiv.classList.remove("hidden");
    hiddenDiv.classList.add("visible");
  });

  hiddenDiv.addEventListener("mouseleave", function () {
    hiddenDiv.classList.remove("visible");
    hiddenDiv.classList.add("hidden");
  });
});

function toggleMenu() {
  var menu = document.querySelector(".menu");
  var overlay = document.getElementById("overlay");

  menu.classList.toggle("show");
  overlay.classList.toggle("show");

  if (menu.classList.contains("show")) {
    document.body.style.overflow = "hidden";
  } else {
    document.body.style.overflow = "";
  }
}

let currentIndexMobile = 0;
let currentIndexPC = 0;

function showImageMobile(index) {
  const imagesContainer = document.querySelector(
    ".carousel.mobile-img .carousel-images"
  );
  const totalImages = imagesContainer.querySelectorAll("img").length;

  if (index >= totalImages) {
    currentIndexMobile = 0;
  } else if (index < 0) {
    currentIndexMobile = totalImages - 1;
  } else {
    currentIndexMobile = index;
  }

  const translateX = -currentIndexMobile * 100;
  imagesContainer.style.transform = `translateX(${translateX}%)`;
}

function showImagePC(index) {
  const imagesContainer = document.querySelector(
    ".carousel.cp-img .carousel-images"
  );
  const totalImages = imagesContainer.querySelectorAll("img").length;

  if (index >= totalImages) {
    currentIndexPC = 0;
  } else if (index < 0) {
    currentIndexPC = totalImages - 1;
  } else {
    currentIndexPC = index;
  }

  const translateX = -currentIndexPC * 100;
  imagesContainer.style.transform = `translateX(${translateX}%)`;
}

function nextImageMobile() {
  showImageMobile(currentIndexMobile + 1);
}

function nextImagePC() {
  showImagePC(currentIndexPC + 1);
}

showImageMobile(currentIndexMobile);
showImagePC(currentIndexPC);

setInterval(nextImageMobile, 5000);
setInterval(nextImagePC, 5000);

const carouselImages = document.querySelector('.carousel-images-brands');
const images = carouselImages.querySelectorAll('img');

let currentIndex = 0;
const totalImages = images.length;
const imageWidth = images[0].clientWidth;
const transitionTime = 0.5;

function nextImage() {
    currentIndex = (currentIndex + 1) % totalImages;
    const translateX = -currentIndex * imageWidth;

    carouselImages.style.transition = `transform ${transitionTime}s ease`;
    carouselImages.style.transform = `translateX(${translateX}px)`;

    if (currentIndex === totalImages - 1) {
        setTimeout(() => {
            carouselImages.style.transition = 'none';
            carouselImages.style.transform = `translateX(0)`;
            currentIndex = 0;
        }, transitionTime * 1000);
    }
}

setInterval(nextImage, 2000);
