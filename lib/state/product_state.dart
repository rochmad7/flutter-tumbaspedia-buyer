part of '../cubit/product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({this.products});
}

class ProductsByShopLoaded extends ProductState {
  final List<Product> products;

  ProductsByShopLoaded({this.products});
}

class ProductLoadingFailed extends ProductState {
  final String message;

  ProductLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
