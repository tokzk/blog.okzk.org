$ ->
  $(document.links).filter ->
    this.hostname != window.location.hostname
  .attr('target', '_blank')

  $('table').addClass('table table-bordered')
