import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';


part 'events_provider.g.dart';

// TODO add here all use cases as functions
@riverpod
Future<List<EventModel>> fetchEvents(FetchEventsRef ref) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  ref.keepAlive();

  return eventsRepository.fetchEvents();
}

@riverpod
Future<void> addEvent(
    AddEventRef ref, {
      required EventModel event,
    }
){
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  ref.keepAlive();

  return eventsRepository.addEvent(event)
      .then((_) => ref.refresh(fetchEventsProvider));
}