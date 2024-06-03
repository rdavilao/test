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

document.addEventListener('DOMContentLoaded', function() {
    var toggleButton = document.getElementById('toggleButton-Service');
    var hiddenDiv = document.getElementById('hiddenService-menu');
  
    toggleButton.addEventListener('click', function() {
      if (hiddenDiv.classList.contains('hidden')) {
        hiddenDiv.classList.remove('hidden');
        hiddenDiv.classList.add('visible');
      } else {
        hiddenDiv.classList.remove('visible');
        hiddenDiv.classList.add('hidden');
      }
    });
  });
