$(document).ready( function () {
  //handle CSS
  $('#calendar').fullCalendar('option', 'height', $('.nav-left')[0].offsetHeight);

  //setup models
  var Calendar = function() {
    this.events = function(){
      return jQuery.parseJSON($("#eventsJson").html()).map(function(obj){
        return calendar.wrapEvent(obj);
      });
    };
    this.wrapEvent = function(event) {
      event.allDay = true;
      switch (event.event_type) {
        case "Anniversary":
          event.color = "red";
          break;
        case "Birthday":
          event.color = "black";
          break;
        default :
          event.color = "green";
      }
      return event;
    };
    this.newEvent = function(date){
      return $.ajax({
        method: 'GET',
        url: calendar.newEventPath(),
        data: {date: date}
      });
    };
    this.newEventPath = function(){
      return $("#newEventPath").html();
    };
    this.createEventPath = function(){
      return $("#eventCreatePath").html();
    };
    this.createEvent = function(formData){
      return $.ajax({
        method: 'POST',
        url: calendar.createEventPath(),
        data: formData
      })
    };
  };
  var Event = function() {
    this.createPath = $("#eventCreatePath").html();
  };

  var calendar = new Calendar();

  //setup controller
  $('#calendar').fullCalendar({
    events: calendar.events(),
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
      calendar.newEvent(date).done(function(data){
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
    calendar.createEvent( $(".formDrop form").serialize()).done(function (event){
      if(event instanceof Object) {
        //success
        $('#newEvent').modal('toggle');
        //add colors here
        $('#calendar').fullCalendar('renderEvent', calendar.wrapEvent(event));
      } else {
        //invalid
        $(".formDrop").html( event );
      }
    });
  };
});
