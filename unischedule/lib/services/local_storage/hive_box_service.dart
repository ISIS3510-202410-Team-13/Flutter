import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unischedule/constants/constants.dart';

class HiveBoxServiceFactory {

  static final HiveBoxServiceFactory _instance = HiveBoxServiceFactory();
  static final Map<String, HiveBoxService> _boxes = {};
  static final List<String> _boxNames = [
    LocalStorageConstants.friendBox,
    LocalStorageConstants.eventBox,
    LocalStorageConstants.groupBox,
  ];

  HiveBoxServiceFactory();

  Future<void> initHive() async {
    await Hive.initFlutter();
    for (String boxName in HiveBoxServiceFactory._boxNames) {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox(boxName);
        _boxes[boxName] = HiveBoxService(boxName);
      }
    }
  }

  static HiveBoxService getService(String boxName) {
    if (!_boxes.containsKey(boxName)) {
      throw Exception('Box $boxName not found');
    } else {
      return _boxes[boxName]!;
    }
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

  Future<void> put(String key, T value) async {
    await box.put(key, value);
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }
}