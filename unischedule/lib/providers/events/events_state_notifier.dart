import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/models.dart';

class EventsStateNotifier extends StateNotifier<List<EventModel>> {
  List<EventModel> allEvents = [];

  EventsStateNotifier(List<EventModel> initialEvents) : super(initialEvents) {
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

  void setEvents(List<EventModel> events) {
    state = events;
    allEvents = events;
  }

  void addEvent(EventModel event) {
    state = [...state, event];
    allEvents = [...allEvents, event];
  }
}

final eventsStateNotifierProvider = StateNotifierProvider<EventsStateNotifier, List<EventModel>>((ref) {
  return EventsStateNotifier([]);
});
