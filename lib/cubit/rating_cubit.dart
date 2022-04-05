import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:doltinuku/models/models.dart';
import 'package:doltinuku/services/services.dart';

part '../state/rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  Future<void> getRatings(
      int start, int limit, int productId, int userId) async {
    ApiReturnValue<List<Rating>> result =
        await RatingServices.getRatings(start, limit, productId, userId);

    if (result.value != null) {
      emit(RatingLoaded(ratings: result.value));
    } else {
      emit(RatingLoadingFailed(result.message));
    }
  }

  Future<void> submit(Transaction transaction, Product product, double rating,
      String review, bool noUpdate) async {
    ApiReturnValue<Rating> result = await RatingServices.submit(
        transaction, product, rating, review, noUpdate);

    if (result.value != null) {
      emit(RatingAdded(result.value));
    } else {
      emit(RatingAddedFailed(result.message, result.error));
    }
  }

  Future<Rating> checkRating(Transaction transaction) async {
    ApiReturnValue<Rating> result =
        await RatingServices.checkRating(transaction);

    if (result.value != null) {
      emit(RatingByTransactionLoaded(rating: result.value));
      return result.value;
    } else {
      emit(RatingLoadingFailed(result.message));
      return null;
    }
  }

  Future<void> update(int ratingId, double rating,
      String review) async {
    ApiReturnValue<Rating> result = await RatingServices.update(
        ratingId, rating, review);

    if (result.value != null) {
      emit(RatingEdited(result.value));
    } else {
      emit(RatingEditedFailed(result.message, result.error));
    }
  }
}
