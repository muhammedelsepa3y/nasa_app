part of 'mars_photo_cubit.dart';

@immutable
abstract class MarsPhotoState {}

class MarsPhotoInitial extends MarsPhotoState {}
class MarsPhotoLoading extends MarsPhotoState {}
class MarsPhotoNoDataError extends MarsPhotoState {}
class MarsPhotoLoaded extends MarsPhotoState {
  final List<MarsPhoto> marsPhotos;
  MarsPhotoLoaded(this.marsPhotos);
}
class MarsPhotoInternetError extends MarsPhotoState {}
class MarsPhotoUnknownError extends MarsPhotoState {
  final String message;
  MarsPhotoUnknownError(this.message);
}
