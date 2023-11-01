import 'package:hive_flutter/hive_flutter.dart';
import 'package:nasa_app/data/models/mars_photo.dart';

import 'constants.dart';

class HiveManager{
  static Future<void> initHive() async {
    await Hive.initFlutter();
     Hive.registerAdapter(MarsPhotoAdapter());
     Hive.registerAdapter(CameraAdapter());
    await Hive.openBox(settingsBox);
    await Hive.openBox<MarsPhoto>(marsPhotoBox);
  }

  static void saveListMarsPhoto(List<MarsPhoto> marsPhotos) {
    Box<MarsPhoto> box = Hive.box<MarsPhoto>(marsPhotoBox);
    marsPhotos.forEach((element) {
      box.put(element.id, element);
    });
  }
  static List<MarsPhoto> getListMarsPhoto(DateTime givenDate) {
    Box<MarsPhoto> box = Hive.box<MarsPhoto>(marsPhotoBox);
    List<MarsPhoto> marsPhotos = [];
    for (int i = 0; i < box.length; i++) {
      MarsPhoto marsPhoto = box.getAt(i)!;
      if (marsPhoto.earthDate == givenDate) {
        marsPhotos.add(marsPhoto);
      }
    }
    return marsPhotos;
  }
}