var CalendarEvent = function CalendarEvent(event) {
  function init(event) {
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
  }

  init(event);
  return this.source = event;
};
