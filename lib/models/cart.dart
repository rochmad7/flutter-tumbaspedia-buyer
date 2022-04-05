part of 'models.dart';

class Cart extends Equatable {
  final int id;
  final String name;
  final String icon;

  Cart({this.id, this.name, this.icon});

  factory Cart.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Cart(
        id: data["id"],
        name: data["name"],
        icon: baseURLStorage + data["icon"],
      );
    }
    return null;
  }

  Cart copyWith({
    int id,
    String name,
    String icon,
  }) {
    return Cart(
        id: id ?? this.id, name: name ?? this.name, icon: icon ?? this.icon);
  }

  @override
  List<Object> get props => [id, name, icon];
}

// Our demo Cart

List<Cart> mockCarts = [
  Cart(
    id: 0,
    name: "Semua",
    icon: baseURLStorage + "assets/img/category/default.svg",
  ),
  Cart(
    id: 1,
    name: "Kuliner",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Cart(
    id: 2,
    name: "Handicraft",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Cart(
    id: 3,
    name: "Jasa",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Cart(
    id: 4,
    name: "Toiletris",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Cart(
    id: 5,
    name: "Kosmetik",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Cart(
    id: 6,
    name: "Herbal",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Cart(
    id: 1,
    name: "Toko",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
  Cart(
    id: 1,
    name: "Lain",
    icon:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
  ),
];
