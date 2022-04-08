part of 'models.dart';

class Shop extends Equatable {
  final int id;
  final String name, description;
  final String shopPicture;
  final String address;
  final User user;

  // final double rating;
  // final int totalProducts;
  final bool isOpen;
  final String openedAt;
  final String closedAt;

  Shop({
    this.id,
    this.user,
    this.address,
    this.name,
    this.shopPicture,
    this.description,
    // this.rating,
    // this.totalProducts,
    this.isOpen,
    this.openedAt,
    this.closedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Shop(
        id: data["id"],
        user: data["user"] != null ? User.fromJson(data["user"]) : null,
        address: data["address"],
        name: data["name"],
        shopPicture: data["shop_picture"],
        // totalProducts: data["total_products"] != null
        //     ? int.parse(data["total_products"].toString())
        //     : 0,
        description: data["description"],
        openedAt: data["opened_at"],
        closedAt: data["closed_at"],
        isOpen: data["is_open"],
        // isOpen: (int.parse(data["is_open"].toString()) == 0) ? false : true,
        // rating: data["rating"] != null
        //     ? double.parse(data["rating"].toString())
        //     : 0,
      );
    }
    return null;
  }

  Shop copyWith(
      {int id,
      User user,
      String address,
      String name,
      String images,
      String description,
      bool status,
      int totalProducts,
      String openingHours,
      String closedHours,
      double rating}) {
    return Shop(
      id: id ?? this.id,
      user: user ?? this.user,
      address: address ?? this.address,
      name: name ?? this.name,
      shopPicture: images ?? this.shopPicture,
      // totalProducts: totalProducts ?? this.totalProducts,
      description: description ?? this.description,
      openedAt: openingHours ?? this.openedAt,
      closedAt: closedHours ?? this.closedAt,
      isOpen: status ?? this.isOpen,
      // rating: rating ?? this.rating
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        address,
        shopPicture,
        // totalProducts,
        description,
        // rating,
        user,
        isOpen,
        openedAt,
        closedAt,
      ];
}
