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
  final HiveBoxService<EventModel> eventSyncModelBox;
  final Ref ref;

  EventsRepositoryImpl({
    required this.ref,
    required this.client,
    required this.boxService,
    required this.eventSyncModelBox,
  });

  @override
  Future<List<EventModel>> fetchEvents() async {
    final userId = ref.watch(authenticationStatusProvider)?.uid;
    if (userId == null) {
      throw Exception(StringConstants.unauthorizedRequest);
    }
    List<EventModel> events = boxService.getAll();
    if (events.isEmpty) {
      try {
        final response = await client.getRequest('user/$userId/events');
        events = response.map<EventModel>((json) => EventModel.fromJson(json)).toList();
        Map<String, EventModel> eventMap = {
          for (var event in events) event.id: event
        };
        await boxService.putAll(eventMap);
      } catch (error) {
        events = List.empty();
        print('Failed to fetch events: $error');
      }
    }
    return events;
  }

  Future<void> syncLocalEvents() async{
    final userId = ref.watch(authenticationStatusProvider)?.uid;
    if (userId == null) {
      throw Exception(StringConstants.unauthorizedRequest);
    }
    var unsyncedEvents = eventSyncModelBox.getAll();
    for (var event in unsyncedEvents) {
          try {
            final response = await client.postRequest('user/$userId/events', data: event.toJson());
            boxService.put(response['eventId'], event);
            boxService.delete(event.id);
            eventSyncModelBox.delete(event.id);
          } catch (error) {
            print('Still failed to sync event: $error');
            // Si falla de nuevo, simplemente lo deja en el almacenamiento para intentarlo más tarde
          }
        }
  }

@override
Future<void> addEvent(EventModel event) async {
  final userId = ref.watch(authenticationStatusProvider)?.uid;
  if (userId == null) {
    throw Exception(StringConstants.unauthorizedRequest);
  }
  boxService.put(event.id, event);
   try {
    final response = await client.postRequest('user/$userId/events', data: event.toJson());
    boxService.put(response['eventId'], event);
    boxService.delete(event.id);
  } catch (error) {
    print('Failed to add event: $error');
    eventSyncModelBox.put(event.id, event);
  }
}
}

@riverpod
EventsRepositoryImpl eventsRepository(EventsRepositoryRef ref) {
  return EventsRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.EVENTS_BASE_URL),
    boxService: HiveBoxServiceFactory.eventModelBox,
    eventSyncModelBox: HiveBoxServiceFactory.eventSyncModelBox,
  );
}