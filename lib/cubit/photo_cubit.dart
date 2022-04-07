import 'package:bloc/bloc.dart';
import 'package:tumbaspedia/models/models.dart';
import 'package:tumbaspedia/services/services.dart';
import 'package:equatable/equatable.dart';

part '../state/photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoInitial());

  Future<void> getPhotos(int start, int limit, int productId) async {
    ApiReturnValue<List<Photo>> result =
        await PhotoServices.getPhotos(start, limit, productId);

    if (result.value != null) {
      emit(PhotoLoaded(photos: result.value));
    } else {
      emit(PhotoLoadingFailed(result.message));
    }
  }

  Future<void> getPhotosByProduct(Product product) async {
    ApiReturnValue<List<Photo>> result =
        await PhotoServices.getPhotosByProduct(product);

    if (result.value != null) {
      emit(PhotosByProductLoaded(photos: result.value));
    } else {
      emit(PhotoLoadingFailed(result.message));
    }
  }
}
