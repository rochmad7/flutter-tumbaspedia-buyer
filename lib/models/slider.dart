part of 'models.dart';

class Slider extends Equatable {
  final int id;
  final String images;

  Slider({
    this.id,
    this.images,
  });

  factory Slider.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Slider(
        id: data["id"],
        images: data["picturePath"],
      );
    }
    return null;
  }

  Slider copyWith({
    int id,
    String images,
  }) {
    return Slider(
      id: id ?? this.id,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [
        id,
        images,
      ];
}

// Our demo Photos

List<Slider> mockSliders = [
  Slider(
    id: 1,
    images: baseURLStorage + 'assets/img/slider/1.jpg',
  ),
  Slider(
    id: 2,
    images: baseURLStorage + 'assets/img/slider/2.jpg',
  ),
];
