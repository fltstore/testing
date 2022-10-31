import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  late Box box;

  init({
    boxName = 'dev',
  }) async {
    await Hive.initFlutter();
    box = await Hive.openBox(boxName);
  }

  setItem<T>(String k, T v) {
    return box.put(k, v);
  }

  getItem<T>(String k, T defaultVal) {
    var data = box.get(k);
    if (data == null) return defaultVal;
    return data as T;
  }
}

LocalStorage localStorage = LocalStorage();
