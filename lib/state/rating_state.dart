part of '../cubit/rating_cubit.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoaded extends RatingState {
  final List<Rating> ratings;

  RatingLoaded({this.ratings});
}

class RatingsByProductLoaded extends RatingState {
  final List<Rating> ratings;

  RatingsByProductLoaded({this.ratings});
}

class RatingByTransactionLoaded extends RatingState {
  final Rating rating;

  RatingByTransactionLoaded({this.rating});
}

class RatingLoadingFailed extends RatingState {
  final String message;

  RatingLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class RatingAdded extends RatingState {
  final Rating ratings;

  RatingAdded(this.ratings);

  @override
  List<Object> get props => [ratings];
}

class RatingAddedFailed extends RatingState {
  final String message;
  final Map<String, dynamic> error;

  RatingAddedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class RatingEdited extends RatingState {
  final Rating ratings;

  RatingEdited(this.ratings);

  @override
  List<Object> get props => [ratings];
}

class RatingEditedFailed extends RatingState {
  final String message;
  final Map<String, dynamic> error;

  RatingEditedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class RatingDeleted extends RatingState {
  final String message;

  RatingDeleted(this.message);

  @override
  List<Object> get props => [message];
}

class RatingDeletedFailed extends RatingState {
  final String message;
  final Map<String, dynamic> error;

  RatingDeletedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}
