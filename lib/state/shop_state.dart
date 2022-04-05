part of '../cubit/shop_cubit.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoaded extends ShopState {
  final List<Shop> shops;
  final bool hasReachedMax;

  ShopLoaded({this.shops, this.hasReachedMax});

  @override
  List<Object> get props => [shops, hasReachedMax];
}

class ShopLoadingFailed extends ShopState {
  final String message;

  ShopLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
