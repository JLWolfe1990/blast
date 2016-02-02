$(document).ready( function () {
  $('#calendarContainer').fullCalendar({
    dayClick: function(date, jsEvent, view) {
      debugger;
      alert('a day has been clicked!');
    }
  });
});
