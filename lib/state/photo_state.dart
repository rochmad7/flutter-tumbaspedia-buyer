part of '../cubit/photo_cubit.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;

  PhotoLoaded({this.photos});
}

class PhotosByProductLoaded extends PhotoState {
  final List<Photo> photos;

  PhotosByProductLoaded({this.photos});
}

class PhotoLoadingFailed extends PhotoState {
  final String message;

  PhotoLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
