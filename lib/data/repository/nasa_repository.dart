import 'package:nasa_app/data/models/mars_photo.dart';

import '../API/network_service.dart';

class NasaRepository{
  final NetworkServices _api;

  NasaRepository(this._api);

  Future<List<MarsPhoto>> fetchImages(DateTime givenDate) async {
    try {
      List<dynamic> photos = await _api.getMarsPhoto(givenDate);
      return photos.map((photoJson) => MarsPhoto.fromJson(photoJson)).toList();
    } catch(e){
      rethrow;
    }
  }
}

