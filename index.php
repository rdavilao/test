<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <title>Workshop City Australia</title>
  <meta name="description" content="" />
  <meta name="keywords" content="" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">

  <meta name="apple-mobile-web-app-status-bar-style" content="default">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-barstyle" content="default">
  <meta name="theme-color" content="#ffffff">
  <link rel="apple-touch-icon" href="./assets/images/biglogo.png">
  <meta name="apple-mobile-web-app-title" content="Workshop City">
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimal-ui" />

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Poppins:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap"
    rel="stylesheet">

  <!-- favicon -->
  <link rel="icon" href="images/favicon.png" type="image/x-icon">

  <!-- styles -->
  <link href="https://fonts.googleapis.com/css2?family=Material+Icons+Round" rel="stylesheet">
  <link rel="stylesheet" href="./css/main-style.css" type="text/css" />

  <!-- material icons -->
  <link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

  <!-- scripts -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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

        case 'canton-fair': ?>
          .red-text {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ffc546;
            border-bottom: 3px solid #ffc546;
          }

          <?php break;

        case 'join-us': ?>
          .join-us-opt {
            box-sizing: border-box;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            transition: color 0.6s, border-color 0.6s;
            color: #ffc546;
            border-bottom: 3px solid #ffc546;
          }

          <?php break;

        default: ?>
          .home-opt {
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
        <a href="#">
          <img class="header-logo" src="assets/images/home-logo.png" alt="Workshop City" width="100%">
        </a>
      </div>
      <div class="header-right">
        <ul class="header-menu">
          <li><a href="/" class="home-opt">HOME</a></li>
          <li><a href="/canton-fair" class="red-text"><strong>SERVICES</strong></a></li>
          <li><a href="/contact-us" class="contact-us-opt">MOBILE SERVICES</a></li>
          <li><a href="/join-us" class="join-us-opt">FAQS</a></li>
          <li><a href="/join-us" class="join-us-opt">ABOUT US</a></li>
          <li><a href="/join-us" class="join-us-opt">CONTACT US</a></li>
        </ul>
      </div>
      <div class="header-book-service">
        <h2>BOOK A SERVICE</h2>
        <div class="header-book-service-divider"></div>
        <h2>0430 003 880</h2>
      </div>
    </div>
  </div>
  <div class="content-wrap">
    <?php
    if (isset($_GET['page'])) {
      $page = $_GET['page'];
      switch ($page) {
        case 'about-us':
          @include ('pages/aboutus.php');
          break;
        case 'contact-us':
          @include ('pages/contactus.php');
          break;
        case 'canton-fair':
          @include ('pages/cantonfair.php');
          break;
        case 'join-us':
          @include ('pages/joinus.php');
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
        <ul class="ul-footer"> 
          <li>SERVICES</li>
          <li>MOBILE SERVICES</li>
        </ul>        
        <div class="footer-book-service">
          <span><h2 style="margin:0;">BOOK A</h2><br /><h2 style="margin:0; margin-top:-1.5rem">SERVICE</h2></span>
          <div class="footer-book-service-space"></div>
          <span><h2 style="margin:0; font-style: italic; font-weight:1">CALL US</h2><br /><h2 style="margin:0; margin-top:-1.5rem">0430 003 880</h2></span>
        </div>
      </div>
      <div class="footer-section-3">
      <span><h2 style="margin:0; font-style: italic; font-weight:1">FOLLOW US</h2><br class="cp-img"/> 
      <a href="#"> <img src="../assets/images/home-fb-footer.png" alt="Workshop City Facebook"></a>
      <a href="#"> <img src="../assets/images/home-insta-footer.png" alt="Workshop City Instagram"></span></a>      
      </div>    
    </div>
    <div class="footer-second-sub-section">
      <div class="section footer-copyright">
        <span>Copyright &copy; 2024 <span style="font-weight:bold"> WORKSHOP CITY - WA</span><br />All Rights Reserved</span>
      </div>      
    </div>        
  </div>
</body>

</html>