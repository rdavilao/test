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

let carouselImages;
let images;

let currentIndex = 0;
let totalImages;
let imageWidth;
const transitionTime = 0.5;
let visibleImages;
let flagDirection = true;
let translateX;

function nextImage() {
  if (flagDirection) {
    currentIndex = (currentIndex + 1) % totalImages;
    translateX = -currentIndex * imageWidth;
  } else {
    currentIndex = (currentIndex - 1) % totalImages;
    translateX = -currentIndex * imageWidth;
  }
  carouselImages.style.transition = `transform ${transitionTime}s ease`;
  carouselImages.style.transform = `translateX(${translateX}px)`;

  if (currentIndex + visibleImages === totalImages) {
    flagDirection = false;
  }

  if (currentIndex === 0) {
    flagDirection = true;
  }
}

function imageWait() {
  carouselImages = document.querySelector(".carousel-images-brands");
  images = carouselImages.querySelectorAll("img");
  totalImages = images.length;
  imageWidth = images[0].clientWidth;
  visibleImages = Math.trunc(screen.width / imageWidth);
  setInterval(nextImage, 2000);
}

setTimeout(imageWait, 5000);
