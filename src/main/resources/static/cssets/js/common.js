var IS_IPAD = navigator.userAgent.match(/iPad/i) != null,
  IS_IPHONE = !IS_IPAD && (navigator.userAgent.match(/iPhone/i) != null || navigator.userAgent.match(/iPod/i) != null),
  IS_IOS = IS_IPAD || IS_IPHONE,
  IS_ANDROID = !IS_IOS && navigator.userAgent.match(/android/i) != null,
  IS_MOBILE = IS_IPHONE || IS_ANDROID;

var AOS_SCHEME = "com.kstc.hwik.hwikgo",
  AOS_ID = "com.kstc.hwik.pine",
  IOS_ID = "id1544045770";
var AOS_URL = "market//detail?id=" + AOS_ID,
  IOS_URL = "https://itunes.apple.com/kr/app/" + IOS_ID;

function app_download(device) {
  if (IS_IOS || device === "ios") {
    return window.open(IOS_URL);
  }
  if (IS_ANDROID || device === "aos") {
    return window.open('https://play.google.com/store/apps/details?id=' + AOS_SCHEME);
  }
}

var $doc = $('html, body'),
  lastScrollTop;

$.lockBody = function() {
  $doc.css({
    height: "100%",
    overflow: "hidden"
  });
};

$.unlockBody = function() {
  $doc.css({
    height: "",
    overflow: ""
  });
  window.scrollTo(0, lastScrollTop);
  window.setTimeout(function () {
    lastScrollTop = null;
  }, 0);
};

$(function () {
  $('a[href="#"], button').on("click", function (e) {
    e.preventDefault();
  });

  // AOS.init({
  //   dealy: 200,
  //   once: true
  // });
  
  var windowW = $(window).width(),
    windowH = $(window).height(),
    $body = $('body'),
    $header = $('header'),
    $tnbNav = $('nav#tnb'),
    $btnScroll = $('#btn-scroll'),
    $btnDropdown = $('#btn-dropdown'),
    $btnMobileMenu = $('#btn-mobile-menu'),
    $dropdown = $('div.dropdown'),
    $menuLinks = $('menu a');
  
  var isSmallUI = function () {
    if (IS_MOBILE) {
      return true;
    }
    return !!$body.hasClass('small');
  };
  
  function checkSmall() {
    $body[windowW > 680 ? 'removeClass' : 'addClass']('small');
    
    if (!isSmallUI() && $tnbNav.find('.logo img').is(':visible') === false) {
      $tnbNav.find('.logo img').show();
    }
  }
  
  var lastScrollTop = 0;
  function windowScrolled() {
    var $this = $(this)
      , top = $this.scrollTop()
      , headerHeight = String($header.outerHeight()).replace(/\D/g, '')
      , topPosition = top >= headerHeight ? headerHeight * -1 : top * -1
      , headerCSS = {}
    ;
    
    if (top > lastScrollTop) {
      headerCSS = {
        top: topPosition + 'px',
        backgroundColor: '#fff'
  
      }
    } else {
      headerCSS = {
        top: '0',
        backgroundColor: top === 0 ? '#fff' : '#fcfcfc'
      };
    }
    if (window.location.pathname === '/company.html') {
      delete headerCSS.backgroundColor;
    }
  
    $header.css(headerCSS);
    lastScrollTop = top;
  }
  
  checkSmall();
  $(window)
    .on('scroll', windowScrolled)
    .on('resize', function () {
      windowW = $(this).width();
      windowH = $(this).height();
      checkSmall();
    });
  
  // 이용방법
  $(document).on('click', 'button', function (e) {
    var $button = $(this)
      , index = $button.data('index')
      , $content = $('div[data-guide="' + index + '"]')
    ;
    e.preventDefault();
    
    $('button[data-index]').not($button).removeClass('on');
    $button.addClass('on');
    
    $('div[data-guide]').not($content).hide();
    $content.fadeIn();
  });
  
  $(document).on('mousewheel', '#guide', function (e) {
    var direction;
    var index = $('button.on[data-index]').data('index');
    if(e.originalEvent.wheelDelta / 120 > 0) {
      direction = 'up'
    } else {
      direction = 'down'
    }
  
    console.log('index', index, direction)

    e.stopPropagation();
  });
  
  $btnScroll.on('click', function (e) {
    e.preventDefault();
    $('html, body').animate({ scrollTop: 0 }, 0);
  });
  
  $btnDropdown.on('click', function (e) {
    e.preventDefault();
    var $this = $(this),
      $parent = $this.parent(),
      hasActive = $parent.hasClass('active');
    $parent[hasActive ? 'removeClass' : 'addClass']('active');
  });
  
  $dropdown.find('a').on('click', function (e) {
    $dropdown.removeClass('active');
  });
  
  $(document).on('click', function (e) {
    var $this = $(e.target);
    if (!$this.closest('div.dropdown').length) {
      $dropdown.removeClass('active');
    }
  });
  
  $btnMobileMenu.on('click', function (e) {
    e.preventDefault();
    var $this = $(this),
      $parent = $this.closest('header'),
      hasActive = $parent.hasClass('active');
    $body[hasActive ? 'removeClass' : 'addClass']('scroll-disabled');
    $parent[hasActive ? 'removeClass' : 'addClass']('active');
    
    //$tnbNav.css({ position: hasActive ? 'absolute' : 'fixed' });
  });
  
  $menuLinks.on('click', function (e) {
    $body.removeClass('scroll-disabled');
    $header.removeClass('active');
    //$tnbNav.css({ position: 'absolute' });
  });
});
