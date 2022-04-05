part of 'models.dart';

class Shop extends Equatable {
  final int id;
  final String name, description;
  final String images;
  final String address;
  final User user;
  final double rating;
  final int totalProducts;
  final bool status;
  final String openingHours;
  final String closedHours;

  Shop({
    this.id,
    this.user,
    this.address,
    this.name,
    this.images,
    this.description,
    this.rating,
    this.totalProducts,
    this.status,
    this.openingHours,
    this.closedHours,
  });

  factory Shop.fromJson(Map<String, dynamic> data) {
    if (data != null) {
      return Shop(
        id: data["id"],
        user: data["user"] != null ? User.fromJson(data["user"]) : null,
        address: data["address"],
        name: data["name"],
        images: data["picturePath"],
        totalProducts: data["total_products"] != null
            ? int.parse(data["total_products"].toString())
            : 0,
        description: data["description"],
        openingHours: data["opening_hours"],
        closedHours: data["closed_hours"],
        status: (int.parse(data["status"].toString()) == 0) ? false : true,
        rating: data["rating"] != null
            ? double.parse(data["rating"].toString())
            : 0,
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
        images: images ?? this.images,
        totalProducts: totalProducts ?? this.totalProducts,
        description: description ?? this.description,
        openingHours: openingHours ?? this.openingHours,
        closedHours: closedHours ?? this.closedHours,
        status: status ?? this.status,
        rating: rating ?? this.rating);
  }

  @override
  List<Object> get props => [
        id,
        name,
        address,
        images,
        totalProducts,
        description,
        rating,
        user,
        status,
        openingHours,
        closedHours,
      ];
}

// Our demo Shops

List<Shop> mockShops = [
  Shop(
    id: 1,
    images:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    name: "Sate Sayur Sultan",
    address: "Gedawang Banyumanik Semarang",
    description:
        "Sate Sayur Sultan adalah menu sate vegan paling terkenal di Bandung. Sate ini dibuat dari berbagai macam bahan bermutu tinggi. Semua bahan ditanam dengan menggunakan teknologi masa kini sehingga memiliki nutrisi yang kaya.",
    rating: 4.1,
    user: mockUser,
  ),
  Shop(
    id: 2,
    images:
        "https://asset.kompas.com/crops/jkNP_agD7gx2WXm6DlU3ZwCZgCs=/0x105:968x750/750x500/data/photo/2017/10/12/2656601819.jpg",
    name: "Outlet Kerajinan Semarang",
    address: "Gedawang Banyumanik Semarang",
    description:
        "Berbagai produk rumah tangga yang terbuat dari rotan, harga terjangkau, kualitas berani diadu",
    rating: 4.1,
    user: mockUser,
  ),
  Shop(
    id: 3,
    images:
        "https://www.carmudi.co.id/journal/wp-content/uploads/2018/05/car-rentals.jpg",
    name: "Sewa Mobil Semarang",
    address: "Gedawang Banyumanik Semarang",
    description:
        "Sewa mobil harian plus driver Semarang, Jawa Tengah. Melayani penjemputan dan pengantaran, travelling, business trip",
    rating: 4.1,
    user: mockUser,
  ),
  Shop(
    id: 4,
    images:
        "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    name: "Mahkota Snack",
    address: "Jl. Watukaji Raya No.16 RT 3 RW 8 Gedawang",
    description: "Mahkota Snack",
    rating: 4.1,
    user: mockUser,
  ),
];
