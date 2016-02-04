$(document).ready( function () {
  //handle CSS
  $('#calendar').fullCalendar('option', 'height', $('.nav-left')[0].offsetHeight);

  //setup models
  var Event = new function() {
    this.newPath = $("#newEventPath").html();
    this.createPath = $("#eventCreatePath").html();
    this.new = function(date){
      return $.ajax({
        method: 'GET',
        url: Event.newPath,
        data: {date: date}
      });
    };
    this.create = function(formData){
      return $.ajax({
        method: 'POST',
        url: Event.createPath,
        data: formData
      })
    };
    this.options = {allDay: true};
  };

  //setup controller
  $('#calendar').fullCalendar({
    events: jQuery.parseJSON($("#eventsJson").html()),
    eventRender: function (event, element) {
      currentTitle = element.find(".fc-event-title");
      var icon = ""
      switch (event.event_type) {
        case "Anniversary":
          icon = "<i class='fa fa-diamond'></i>";
          break;
        case "Birthday":
          icon = "<i class='fa fa-fast-forward'></i>";
          break;
        default :
          icon = "<i class='fa fa-thumbs-up'></i>";
      }
      currentTitle.html(icon + " " + currentTitle.html());
    },
    dayClick: function(date, jsEvent, view) {
      Event.new(date).done(function(data){
        $(".formDrop").html( data );
        $('#newEvent').modal('toggle');
        $(".formDrop form").submit( function(event){
          document.submitEvent();
          event.preventDefault();
        });
      });
    },
    eventClick: function(event, element) {
      event.title = "CLICKED!";

      $('#calendar').fullCalendar('updateEvent', event);
    }
  });

  this.submitEvent = function () {
    Event.create( $(".formDrop form").serialize()).done(function (data){
      if(data instanceof Object) {
        //success
        $('#newEvent').modal('toggle');
        $('#calendar').fullCalendar('renderEvent', jQuery.extend(data, Event.options));
      } else {
        //invalid
        $(".formDrop").html( data );
      }
    });
  };
});
