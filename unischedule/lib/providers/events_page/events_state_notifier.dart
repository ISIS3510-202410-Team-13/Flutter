import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/events_page/event_model.dart';

class EventsStateNotifier extends StateNotifier<List<Event>> {
  List<Event> allEvents = [];

  EventsStateNotifier(List<Event> initialEvents) : super(initialEvents) {
    allEvents = initialEvents;
  }

  void filterEvents(String searchText) {
    if (searchText.isEmpty) {
      state = allEvents;
    } else {
      state = allEvents.where((event) =>
        event.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }

  void setEvents(List<Event> events) {
    state = events;
    allEvents = events;
  }
}

final eventsStateNotifierProvider = StateNotifierProvider<EventsStateNotifier, List<Event>>((ref) {
  return EventsStateNotifier([]);
});
