import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/network/dio_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_repository.g.dart';

abstract class EventsRepository {
  // TODO add here all use cases for events
  Future<List<EventModel>> fetchEvents();
}

class EventsRepositoryImpl extends EventsRepository {

  final DioApiService client;
  final Ref ref;

  EventsRepositoryImpl({required this.ref, required this.client});

  @override
  Future<List<EventModel>> fetchEvents() {
    return client.getRequest("user/0MebgXs8fBYREjDKMlwq/events").then((response) { // TODO change endpoint
      return response.map<EventModel>((json) => EventModel.fromJson(json)).toList();
    });
  }

// TODO add onDispose method to save the state of the events
}

@riverpod
EventsRepositoryImpl eventsRepository(EventsRepositoryRef ref) {
  return EventsRepositoryImpl(ref: ref, client: DioApiServiceFactory.getService(HTTPConstants.EVENTS_BASE_URL));
}