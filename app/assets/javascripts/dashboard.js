$(document).ready( function () {
  $('#calendar').fullCalendar({
    dayClick: function(date, jsEvent, view) {
      alert('a day has been clicked!');
    }
  });

  $('#calendar').fullCalendar('option', 'height', $('.nav-left')[0].offsetHeight);
});
