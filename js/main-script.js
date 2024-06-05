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

  toggleButton.addEventListener("click", function () {
    if (hiddenDiv.classList.contains("hidden")) {
      hiddenDiv.classList.remove("hidden");
      hiddenDiv.classList.add("visible");
    } else {
      hiddenDiv.classList.remove("visible");
      hiddenDiv.classList.add("hidden");
    }
  });
});

function toggleMenu() {
  var menu = document.querySelector(".menu");
  var overlay = document.getElementById("overlay");
  menu.classList.toggle("show");
  overlay.classList.toggle("show");
}

let currentIndex = 0;

function showImage(index) {
  const imagesContainer = document.querySelector(".carousel-images");
  const totalImages = imagesContainer.querySelectorAll("img").length;

  if (index >= totalImages) {
    currentIndex = 0;
  } else if (index < 0) {
    currentIndex = totalImages - 1;
  } else {
    currentIndex = index;
  }

  const translateX = -currentIndex * 100;
  imagesContainer.style.transform = `translateX(${translateX}%)`;
}

function nextImage() {
  showImage(currentIndex + 1);
}
showImage(currentIndex);
setInterval(nextImage, 5000);
