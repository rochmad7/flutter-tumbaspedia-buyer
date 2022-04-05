import 'package:bloc/bloc.dart';
import 'package:doltinuku/models/models.dart';
import 'package:doltinuku/services/services.dart';
import 'package:equatable/equatable.dart';

part '../state/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> getProducts(
      String query, int start, int limit, int categoryId, int shopId) async {
    ApiReturnValue<List<Product>> result = await ProductServices.getProducts(
        query, start, limit, categoryId, shopId, null);

    if (result.value != null) {
      emit(ProductLoaded(products: result.value));
    } else {
      emit(ProductLoadingFailed(result.message));
    }
  }

  Future<void> getProductsByShop(Shop shop) async {
    ApiReturnValue<List<Product>> result =
        await ProductServices.getProductsByShop(shop);

    if (result.value != null) {
      emit(ProductsByShopLoaded(products: result.value));
    } else {
      emit(ProductLoadingFailed(result.message));
    }
  }
}
