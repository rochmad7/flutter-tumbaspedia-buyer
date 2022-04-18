part of 'models.dart';

class Photo extends Equatable {
  final int id;
  final String images;

  Photo({
    this.id,
    this.images,
  });

  factory Photo.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Photo(
        id: data["id"],
        images: data["picture_url"],
      );
    }
    return null;
  }

  Photo copyWith({
    int id,
    String images,
  }) {
    return Photo(
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