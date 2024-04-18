import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';

part 'events_repository.g.dart';

abstract class EventsRepository {
  // TODO add here all use cases for events
  Future<List<EventModel>> fetchEvents();
}

class EventsRepositoryImpl extends EventsRepository {

  final DioApiService client;
  final HiveBoxService<EventModel> boxService;
  final Ref ref;

  EventsRepositoryImpl({
    required this.ref,
    required this.client,
    required this.boxService,
  });

  @override
  Future<List<EventModel>> fetchEvents() async {
    List<EventModel> events = await client.getRequest("user/0MebgXs8fBYREjDKMlwq/events") // TODO change endpoint
      .then((response) => response.map<EventModel>((json) => EventModel.fromJson(json)).toList())
      .catchError((error) => boxService.getAll());
    return events;
  }
  // TODO add onDispose method to save the state of the events
}

@riverpod
EventsRepositoryImpl eventsRepository(EventsRepositoryRef ref) {
  return EventsRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.EVENTS_BASE_URL),
    boxService: HiveBoxServiceFactory.getService(LocalStorageConstants.eventBox) as HiveBoxService<EventModel>,
  );
}