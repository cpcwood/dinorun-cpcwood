export default function initalizeSession() {
  $.ajax({
    url: '/session.json',
    type: "GET",
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
  }).done(function( data ) {
    if (data) {
      $('#logged-out').toggle()
    } else {
      $('#logged-in').toggle()
    }
  })
}