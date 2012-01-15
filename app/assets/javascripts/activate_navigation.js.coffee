window.activateNavigation = (project) ->
  $(".project_nav").removeClass("active")
  $("#project_nav_#{project}").addClass("active")
