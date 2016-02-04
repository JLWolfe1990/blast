$(document).ready( function () {
  //setup models
  var Calendar = function() {
    this.events = function(){
      return jQuery.parseJSON($("#eventsJson").html()).map(function(obj){
        return new Event(obj);
      });
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
    this.resize = function(){
      console.log("resize called");
      return $('#calendar').fullCalendar('option', 'height', $('.nav-left').height());
    };
  };

  var Event = function(event) {
    this.source = event;
    var init = function(event) {
      event.allDay = true;
      switch (event.event_type) {
        case "Anniversary":
          event.className = "anniversary";
          break;
        case "Birthday":
          event.className = "birthday";
          break;
        case "Holiday":
          event.className = "holiday";
          break;
        default :
          event.className = "other";
      }
      return event;
    };
    return init(event);
  };

  var calendar = new Calendar();

  //setup view logic
  $('#calendar').fullCalendar({
    header: {
      left: 'prev today',
      center: 'title',
      right: 'next'
    },
    events: calendar.events(),
    eventRender: function (event, element) {
      currentTitle = element.find(".fc-event-title");
      var icon = ""
      switch (event.event_type) {
        case "Anniversary":
          icon = "<i class='fa fa-diamond'></i>";
          break;
        case "Birthday":
          icon = "<i class='fa fa-birthday-cake'></i>";
          break;
        case "Holiday":
          icon = "<i class='fa fa-tree'></i>";
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
    },
    windowResize: function(view){
      calendar.resize();
    },
    eventColor: function(){
      debugger;
      true;
    }
  });

  //setup controller
  document.submitEvent = function () {
    calendar.createEvent( $(".formDrop form").serialize()).done(function (event){
      if(event instanceof Object) {
        //success
        $('#newEvent').modal('toggle');
        //add colors here
        $('#calendar').fullCalendar('renderEvent', new Event(event));
      } else {
        //invalid
        $(".formDrop").html( event );
      }
    });
  };

  calendar.resize();
});
