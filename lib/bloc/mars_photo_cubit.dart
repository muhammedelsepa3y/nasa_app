import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../data/API/network_service.dart';
import '../data/models/mars_photo.dart';

part 'mars_photo_state.dart';

class MarsPhotoCubit extends Cubit<MarsPhotoState> {
  MarsPhotoCubit() : super(MarsPhotoInitial());
  static MarsPhotoCubit get(context) => BlocProvider.of<MarsPhotoCubit>(context);

  Future<void> getMarsPhoto(DateTime dateTime) async {
    try {
      emit(MarsPhotoLoading());
      List<MarsPhoto> marsPhotos = await NetworkServices().getMarsPhoto(dateTime);
      if (marsPhotos.isEmpty) {
        emit(MarsPhotoNoDataError());
      } else {
        emit(MarsPhotoLoaded(marsPhotos));
      }
    } catch (e) {
      if (e is DioException) {
        emit(MarsPhotoInternetError());
      } else {
        emit(MarsPhotoUnknownError(e.toString()));
      }
    }
  }
}
