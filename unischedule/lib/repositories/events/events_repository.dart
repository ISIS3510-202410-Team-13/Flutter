import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';
import 'package:unischedule/providers/providers.dart';

part 'events_repository.g.dart';

abstract class EventsRepository {
  // TODO add here all CRUD operations
  Future<List<EventModel>> fetchEvents();
  Future<void> addEvent(EventModel event);
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
    final userId = ref.watch(authenticationStatusProvider)?.uid;
    if (userId == null) {
      throw Exception(StringConstants.unauthorizedRequest);
    }
    List<EventModel> events = await client.getRequest('user/$userId/events')
      .then((response) => response.map<EventModel>((json) => EventModel.fromJson(json)).toList())
      .then((events) async {
        await boxService.clear();
        await boxService.putAll({ for (var event in events) event.id : event });
        return events;
      })
      .catchError((error) => boxService.getAll());
    return events;
  }

  @override
  Future<void> addEvent(EventModel event) async {
    boxService.put(event.id, event);
    // TODO save event in the database
    //await client.postRequest("user/$userid/events", event.toJson());
  }
}

@riverpod
EventsRepositoryImpl eventsRepository(EventsRepositoryRef ref) {
  return EventsRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.EVENTS_BASE_URL),
    boxService: HiveBoxServiceFactory.eventModelBox,
  );
}