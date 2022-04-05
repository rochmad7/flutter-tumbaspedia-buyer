import 'package:bloc/bloc.dart';
import 'package:doltinuku/models/models.dart';
import 'package:doltinuku/services/services.dart';
import 'package:equatable/equatable.dart';

part '../state/slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());

  Future<void> getSliders(int start, int limit) async {
    ApiReturnValue<List<Slider>> result =
        await SliderServices.getSliders(start, limit);

    if (result.value != null) {
      emit(SliderLoaded(sliders: result.value));
    } else {
      emit(SliderLoadingFailed(result.message));
    }
  }
}
