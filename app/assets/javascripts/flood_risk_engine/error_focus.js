$(window).load(function() {

  // Only set focus for pages with errors
  if ($(".form-group.error").length) {

    // If there is an error summary, set focus to the summary
    if ($(".error-summary").length) {
      $(".error-summary").focus();
      // When the error summary link is clicked focus on the input or textarea
      // of that group
      $(".error-summary a").on('click', function(e) {
        var href = $(this).attr("href");
        $(href + ' .form-control').first().focus();
      });
    }
    // Otherwise, set focus to the field with the error
    else {
      $(".error input:first").focus();
    }
  }

});
