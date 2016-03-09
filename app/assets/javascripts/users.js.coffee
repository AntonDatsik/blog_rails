# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('h4').on 'mouseenter', ->
    $(this).find('.user-profile').slideToggle()
    return
  $('h4').on 'mouseleave', ->
    $(this).find('.user-profile').slideToggle()
    return
  return
