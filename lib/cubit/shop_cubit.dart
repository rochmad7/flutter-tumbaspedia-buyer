import 'package:bloc/bloc.dart';
import 'package:doltinuku/models/models.dart';
import 'package:doltinuku/services/services.dart';
import 'package:equatable/equatable.dart';

part '../state/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  Future<void> getShops(int page, int start, int limit, String query) async {
    ApiReturnValue<List<Shop>> result =
        await ShopServices.getShops(page, start, limit, query);

    if (result.value != null) {
      emit(ShopLoaded(shops: result.value, hasReachedMax: false));
    } else {
      emit(ShopLoadingFailed(result.message));
    }
  }
}
