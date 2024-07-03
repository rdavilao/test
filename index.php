<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <title>Workshop City WA</title>
  <meta name="description" content="" />
  <meta name="keywords" content="" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <meta name="apple-mobile-web-app-status-bar-style" content="default">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-barstyle" content="default">
  <meta name="theme-color" content="#ffffff">
  <link rel="apple-touch-icon" href="./assets/images/favicon2.png">
  <meta name="apple-mobile-web-app-title" content="Workshop City">
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimal-ui" />

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Poppins:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap"
    rel="stylesheet">

  <!-- favicon -->
  <link rel="icon" href="./assets/images/favicon2.png" type="image/x-icon">

  <!-- material icons -->
  <link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <!-- scripts -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


  <!-- styles -->
  <link href="https://fonts.googleapis.com/css2?family=Material+Icons+Round" rel="stylesheet">
  <link rel="stylesheet" href="./css/main-style.css" type="text/css" />
  <!-- Google tag (gtag.js) 
  <script async src="https://www.googletagmanager.com/gtag/js?id=G-X1KN31ZMGJ"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    gtag('config', 'G-X1KN31ZMGJ');
  </script>
-->

</head>

<body>
  <style type="text/css">
    <?php if (isset($_GET['page'])) {
      $page = $_GET['page'];

      switch ($page) {
        case 'about-us': ?>
          .about-us-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'contact-us': ?>
          .contact-us-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'logbook-service': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .logbook-service-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'standard-service': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .standard-service-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'tyres': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .tyres-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'brakes': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .brakes-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'maintenance': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .maintenance-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'inspection': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .registration-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'suspension': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .suspension-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'wheels': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .wheels-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'cooling': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .cooling-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'electrical': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .electrical-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case '4wd': ?>
          .services {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          .wd-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          mobile-services

          <?php break;

        case 'join-us': ?>
          .join-us-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00;
            border-bottom: 3px solid #ff9f00;
          }

          book-opt

          <?php break;

        case 'mobile-services': ?>
          .mobile-services-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;

        case 'book-service': ?>
          .book-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ff9f00 !important;
            border-bottom: 3px solid #ff9f00;
          }

          <?php break;
      }
    } else {
      ?>
      .home-opt {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        -webkit-box-sizing: border-box;
        transition: color 0.6s, border-color 0.6s;
        color: #ff9f00 !important;
        border-bottom: 3px solid #ff9f00;
      }

      <?php
    }
    ?>
  </style>
  <div class="header-wrap">
    <div class="header-inner">
      <div class="header-left">
        <div class="header-left-1">
          <a href="/">
            <img class="header-logo" src="assets/images/home-logo.png" alt="Workshop City" width="100%">
          </a>
        </div>
        <div class="header-left-2">
          <a href="tel:+61430033880"><img src="../assets/images/PHONE-TEST1.png" alt="Workshop City Phone Number"
              class="phone-number-header"></a>
          <div class="mobile-menu mobile-img">
            <nav>
              <div class="menu-icon" onclick="toggleMenu()">
                &#9776;
              </div>
              <ul class="menu">
                <li><a href="/logbook-service" class="logbook-service-opt">LOGBOOK SERVICING</a></li>
                <li><a href="/standard-service" class="standard-service-opt">STANDARD SERVICING</a></li>
                <li><a href="/tyres" class="tyres-opt">TYRES AND BALANCE</a></li>
                <li><a href="/brakes" class="brakes-opt">BRAKES</a></li>
                <li><a href="/maintenance" class="maintenance-opt">MAINTENANCE & REPAIRS</a></li>
                <li><a href="/inspection" class="registration-opt">REGISTRATION & PRE PITS <br>INSPECTION</a></li>
                <li><a href="/suspension" class="suspension-opt">SUSPENSION & SHOCK<br>ABSORBERS</a></li>
                <li><a href="/wheels" class="wheels-opt">WHEELS ALIGNMENT</a></li>
                <li><a href="/cooling" class="cooling-opt">COOLING SYSTEM</a></li>
                <li><a href="/electrical" class="electrical-opt">ELECTRICAL</a></li>
                <li><a href="/4wd" class="wd-opt">4WD ACCESORIES</a></li>
                <li><a href="/mobile-services" class="mobile-services-opt">MOBILE SERVICES</a></li>
                <li><a href="/about-us" class="about-us-opt">ABOUT US</a></li>
                <li><a href="/contact-us" class="contact-us-opt">CONTACT US & FAQS</a></li>
                <li><a href="/book-service" class="book-opt">BOOK NOW</a></li>
              </ul>
            </nav>
          </div>
        </div>
      </div>
      <div class="header-right">
        <ul class="header-menu">
          <li><a href="/" class="home-opt">HOME</a></li>
          <li><a href="#" id="toggleButton-Service" class="services">SERVICES</a></li>
          <li><a href="/mobile-services" class="mobile-services-opt">MOBILE SERVICES</a></li>
          <li><a href="/about-us" class="about-us-opt">ABOUT US</a></li>
          <li><a href="/contact-us" class="contact-us-opt">CONTACT US & FAQS</a></li>
        </ul>
      </div>
      <div class="header-book-service">
        <h2 class="book-a-service" data-url="/book-service" style="margin-left:0">BOOK A SERVICE</h2>
        <div class="header-book-service-divider"></div>
        <a href="tel:+61430033880"><img src="../assets/images/PHONE-TEST1.png" alt="Workshop City Phone Number"
            class="phone-number-header"></a>
      </div>
    </div>
    <div id="hiddenService-menu" class="service-menu hidden">
      <ul class="header-menu-service">
        <li><a href="/logbook-service" class="logbook-service-opt">LOGBOOK SERVICING</a></li>
        <li><a href="/standard-service" class="standard-service-opt">STANDARD SERVICING</a></li>
        <li><a href="/tyres" class="tyres-opt">TYRES AND BALANCE</a></li>
        <li><a href="/brakes" class="brakes-opt">BRAKES</a></li>
        <li><a href="/maintenance" class="maintenance-opt">MAINTENANCE & REPAIRS</a></li>
        <li><a href="/inspection" class="registration-opt">REGISTRATION & PRE PITS INSPECTION</a></li>
        <li><a href="/suspension" class="suspension-opt">SUSPENSION & SHOCK ABSORBERS</a></li>
        <li><a href="/wheels" class="wheels-opt">WHEELS ALIGNMENT</a></li>
        <li><a href="/cooling" class="cooling-opt">COOLING SYSTEM</a></li>
        <li><a href="/electrical" class="electrical-opt">ELECTRICAL</a></li>
        <li><a href="/4wd" class="wd-opt">4WD ACCESORIES</a></li>
      </ul>
    </div>
  </div>
  <div class="content-wrap">
    <?php
    if (isset($_GET['page'])) {
      $page = $_GET['page'];
      switch ($page) {
        case 'about-us':
          @include ('pages/about-us.php');
          break;
        case 'contact-us':
          @include ('pages/contact-us.php');
          break;
        case 'logbook-service':
          @include ('pages/logbook.php');
          break;
        case 'join-us':
          @include ('pages/joinus.php');
          break;
        case 'book-service':
          @include ('pages/book-a-service.php');
          break;
        case 'standard-service':
          @include ('pages/standard.php');
          break;
        case 'tyres':
          @include ('pages/tyres.php');
          break;
        case 'suspension':
          @include ('pages/suspension.php');
          break;
        case 'wheels':
          @include ('pages/wheels.php');
          break;
        case 'cooling':
          @include ('pages/cooling.php');
          break;
        case 'electrical':
          @include ('pages/electrical.php');
          break;
        case 'brakes':
          @include ('pages/brakes.php');
          break;
        case 'maintenance':
          @include ('pages/maintenance.php');
          break;
        case 'inspection':
          @include ('pages/inspection.php');
          break;
        case 'mobile-services':
          @include ('pages/mobile-services.php');
          break;
        case '4wd':
          @include ('pages/4wd.php');
          break;
        default:
          @include ('pages/home.php');
          break;
      }
    } else {
      @include ('pages/home.php');
    }
    ?>
  </div>
  <div class="footer">
    <div class="yellow-line"></div>
    <div class="footer-first-sub-section">
      <div class="footer-section-1">
        <img src="../assets/images/home-logo-wc-footer.png" alt="Workshop City White Logo">
      </div>
      <div class="footer-section-2">
        <div class="footer-divider"></div>
        <ul class="ul-footer" style="color:white !important">
          <li><a href="/logbook-service">SERVICES</a></li>
          <li><a href="/mobile-services">MOBILE SERVICES</a></li>
        </ul>
        <div class="footer-book-service">
          <span class="book-a-service" data-url="/book-service">
            <h3 style="margin:0;">BOOK A</h3><br />
            <h3 style="margin:0; margin-top:-1.5rem">SERVICE</h3>
          </span>
          <div class="footer-book-service-space"></div>
          <a href="tel:+61430033880" class="a-footer">
            <h3>CALL US</h3>
            <img src="../assets/images/PHONE-TEST1.png" alt="Workshop City Phone Number" class="phone-numer-footer">
          </a>
        </div>
        <div class="footer-divider"></div>
      </div>
      <div class="footer-section-3">
        <span>
          <h3 style="margin:0; font-style: italic; font-weight:1">FOLLOW US</h3><br class="cp-img" />
          <a href="#"> <img src="../assets/images/home-fb-footer.png" alt="Workshop City Facebook"></a>
          <a href="#"> <img src="../assets/images/home-insta-footer.png" alt="Workshop City Instagram">
        </span></a>
      </div>
    </div>
    <div class="footer-second-sub-section">
      <div class="section footer-copyright">
        <span>Copyright &copy; 2024 <span style="font-weight:bold"> WORKSHOP CITY - WA</span><br />All Rights
          Reserved</span>
      </div>
    </div>
    <div id="overlay" class="overlay"></div>
    <script src="./js/main-script.js"></script>
</body>

</html>