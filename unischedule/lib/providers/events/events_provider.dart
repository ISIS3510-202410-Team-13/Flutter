import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/events/events_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'events_provider.g.dart';

@riverpod
Future<List<EventModel>> fetchEvents(FetchEventsRef ref) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  ref.keepAlive();

  return eventsRepository.fetchEvents();
}