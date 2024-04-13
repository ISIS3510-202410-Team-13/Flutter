import 'package:unischedule/models/events_page/event_model.dart';
import 'package:unischedule/services/network/events_api_service.dart';

class EventsRepository {
  final EventsApiService _apiService;

  EventsRepository(this._apiService);

  Future<List<Event>> getEvents(String userId, [String? query]) async {
    final data = await _apiService.fetchEvents(userId);
    var events = data.map<Event>((json) => Event.fromJson(json)).toList();

    if (query != null && query.isNotEmpty) {
      events = events.where((event) => event.name.toLowerCase().contains(query.toLowerCase())).toList();
    }

    return events;
  }
}
