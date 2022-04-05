part of '../cubit/slider_cubit.dart';

abstract class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object> get props => [];
}

class SliderInitial extends SliderState {}

class SliderLoaded extends SliderState {
  final List<Slider> sliders;

  SliderLoaded({this.sliders});
}

class SliderLoadingFailed extends SliderState {
  final String message;

  SliderLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
