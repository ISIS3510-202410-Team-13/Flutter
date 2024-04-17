import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';
import 'package:unischedule/services/network/events_api_service.dart';

final eventsApiServiceProvider = Provider<EventsApiService>((ref) {
  return EventsApiService();
});

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository(ref.read(eventsApiServiceProvider));
});

final eventsProvider = FutureProvider.family<List<Event>, String>((ref, userId) {
  final repository = ref.read(eventsRepositoryProvider);
  final searchQuery = ref.watch(eventsSearchQueryProvider);
  return repository.getEvents(userId, searchQuery);
});

final eventsSearchQueryProvider = StateProvider<String>((ref) => "");
