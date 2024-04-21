import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/models/models.dart';

class HiveBoxServiceFactory {
  static late final HiveBoxService<FriendModel> friendModelBox;
  static late final HiveBoxService<EventModel> eventModelBox;
  static late final HiveBoxService<EventModel> eventSyncModelBox;
  static late final HiveBoxService<GroupModel> groupModelBox;

  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(FriendModelAdapter());
    Hive.registerAdapter(EventModelAdapter());
    Hive.registerAdapter(GroupModelAdapter());

    await Hive.openBox<FriendModel>(LocalStorageConstants.friendBox);
    await Hive.openBox<EventModel>(LocalStorageConstants.eventBox);

    await Hive.openBox<GroupModel>(LocalStorageConstants.groupBox);

    friendModelBox = HiveBoxService(LocalStorageConstants.friendBox);
    eventModelBox = HiveBoxService(LocalStorageConstants.eventBox);

    groupModelBox = HiveBoxService(LocalStorageConstants.groupBox);
  }
}

class HiveBoxService<T> {
  final String boxName;
  late Box<T> box;

  HiveBoxService(this.boxName) {
    box = Hive.box(boxName);
  }

  T? get(String key) {
    return box.get(key);
  }

  List<T> getAll() {
    return box.values.toList();
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }

  Future<void> clear() async {
    await box.clear();
  }

  Future<void> put(String key, T value) async {
    await box.put(key, value);
  }

  Future<void> putAll(Map<String, T> values) async {
    await box.putAll(values);
  }
}
