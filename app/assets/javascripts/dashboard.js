$(document).ready( function () {
  //instantiate calendar
  document.calendar = new Calendar({
    header: {
      left: 'prev today',
      center: 'title',
      right: 'next'
    },
    eventRender: function (event, element) {
      var currentTitle = element.find(".fc-event-title");
      var icon = "";
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
      document.calendar.getNewEventForm(date).done( document.handleFormContentUpdate );
    },
    eventClick: function(event, element) {
      document.calendar.getEditEventForm(event, false).done( document.handleFormContentUpdate );
      document.event = event;
    },
    windowResize: function(view){
      document.calendar.resize();
    }
  });

  document.submitEvent = function () {
    document.calendar.createEvent( $(".formDrop form").serialize()).done(function (event){
      if(event instanceof Object) {
        //success
        document.hideModalContents();
        //add colors here
        $('#calendar').fullCalendar('renderEvent', new CalendarEvent(event));
      } else {
        //invalid
        document.setModalContents(event);
      }
    });
  };

  document.submitUpdateEvent = function () {
    document.calendar.updateEvent( document.getForm().serialize()).done(function (event){
      if(event instanceof Object) {
        //success
        document.hideModalContents();
        //add colors here

        $('#calendar').fullCalendar('updateEvent', new CalendarEvent(jQuery.extend(document.event, event)));

        document.event = undefined;
      } else {
        //invalid
        document.setModalContents(event);
      }
    });
  };

  document.handleFormContentUpdate = function(contents) {
    document.setModalContents(contents);
    document.showModalContents();
    document.getForm().submit( function(event){
      $("#submitButton").click();
      event.preventDefault();
    });
  };

  //helpers
  document.setModalContents = function(contents){
    return $("#newEvent").html( contents );
  };

  document.showModalContents = function(){
    return $('#newEvent').modal('show');
  };

  document.hideModalContents = function(){
    return $('#newEvent').modal('hide');
  };

  document.getForm = function () {
    return $("#newEvent form");
  };

  document.addAlertRequest = function () {
    document.calendar.getEditEventForm(document.event, true).done( document.handleFormContentUpdate );
  };

  //fit calendar to container
  document.calendar.resize();
});
