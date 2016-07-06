$(document).ready(function() {
  "use strict";

  // This code fixes behaviour in Chrome and Safari browsers where arrow keys doesn't scroll
  // page but focus does move, so keyboard user can't see focus

  // If we are not on Chrome or Safari then return early
  // (both have Safari in user agent string)
  // Check does not work for IE12 which also reports as Safari
  if (navigator.userAgent.indexOf('Safari') == -1) {
    return;
  }

  // How it works: every time a key is released
  // on an exemption label - avoid this working on other elements because
  // it is then not possible to use arrow keys when eg the continue button has focused
  // also ignore first element because it was jarring to have the screen move on first entry to list
  // label[for^='user_type_org'] selects all the radio labels on the 'Who is responsible..' page
  // .block-label.exemption selects all the radio labels on the 'Select the exemption..' page
  var $radioLabels = $(".block-label.exemption:gt(0), label[for^='user_type_org']:gt(0)"); //:gt(0) not the first element
  $radioLabels.keyup(function(e) {

    // Set keycodes we want to watch for
    var UP = 38;
    var DOWN = 40;
    var ENTER = 13;
    var TAB = 9;
    var SPACE = 32;
    // initialise
    var keynum = 0;

    // obtain key pressed - different in different browsers
    keynum = (e.keyCode || e.which);

    // Only respond to keys used for navigating page
    if(keynum === UP || keynum === DOWN || keynum === ENTER || keynum === TAB || keynum === SPACE) {
      // Find the offset top position of the focused element
      // Remove 50 pixels so we scroll to just above the element
      // Scroll to this position
      // Using animate method, with 'linear' easing, and take 100mS to do that
      $('html, body').animate({ scrollTop: $(":focus").offset().top - 50 }, 100, "linear");
    }

  }); // end keypress function

}); // end document ready
