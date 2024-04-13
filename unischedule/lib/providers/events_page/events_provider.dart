import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/events_page/event_model.dart';
import 'package:unischedule/repositories/events_page/events_repository.dart';
import 'package:unischedule/services/network/events_api_service.dart';

final eventsApiServiceProvider = Provider<EventsApiService>((ref) {
  return EventsApiService();
});

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository(ref.read(eventsApiServiceProvider));
});

final eventsProvider = FutureProvider.family<List<Event>, String>((ref, userId) {
  final repository = ref.read(eventsRepositoryProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  return repository.getEvents(userId, searchQuery);
});

final searchQueryProvider = StateProvider<String>((ref) => "");
