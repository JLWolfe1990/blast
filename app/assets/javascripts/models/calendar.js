var Calendar = function Calendar(initObject) {

  this.parseEvents = function parseEvents(){
    elements = $("#eventsJson").html();
    var events;
    if(elements != undefined) {
      events = jQuery.parseJSON(elements).map(function(obj){
        return new CalendarEvent(obj);
      });
    }
    return events;
  };

  this.getSourceElement = function () {
    return $("#calendar");
  };
  this.getNewEventForm = function(date){
    return $.ajax({
      method: 'GET',
      url: this.getNewEventPath(),
      data: {date: date}
    });
  };
  this.getEditEventForm = function(event, addMore){
    if( addMore ) {
      return $.ajax({
        method: 'GET',
        url: event.edit_path,
        data: {adding_alert_requests:true}
      });
    } else {
      return $.ajax({
        method: 'GET',
        url: event.edit_path
      });
    }
  };
  this.getNewEventPath = function(){
    return $("#newEventPath").html();
  };
  this.getFormSubmitPath = function(){
    return $("#submitButton").attr('data-submit-path');
  };
  this.createEvent = function(formData){
    return $.ajax({
      method: 'POST',
      url: this.getFormSubmitPath(),
      data: formData
    })
  };
  this.updateEvent = function(formData){
    return $.ajax({
      method: 'PUT',
      url: this.getFormSubmitPath(),
      data: formData
    });
  };
  this.resize = function(){
    return this.getSourceElement().fullCalendar('option', 'height', $('.nav-left').height());
  };

  initObject.events = this.parseEvents();
  this.events = initObject.events;
  this.getSourceElement().fullCalendar(initObject);
};
