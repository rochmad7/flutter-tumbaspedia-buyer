part of 'models.dart';

enum TransactionStatus { delivered, on_delivery, pending, cancelled }

class Transaction extends Equatable {
  final int id;
  final Product product;
  final Shop shop;
  final int quantity;
  final int total;
  final DateTime dateTime;
  final DateTime updateTime;
  final DateTime confirmedAt;
  final DateTime deliveredAt;
  final TransactionStatus status;
  final User user;

  Transaction({
    this.id,
    this.product,
    this.user,
    this.shop,
    this.quantity,
    this.total,
    this.dateTime,
    this.updateTime,
    this.confirmedAt,
    this.deliveredAt,
    this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> data) => Transaction(
        id: data["id"],
        product:
            data["product"] != null ? Product.fromJson(data["product"]) : null,
        user: data["user"] != null ? User.fromJson(data["user"]) : null,
        shop: data["shop"] != null ? Shop.fromJson(data["shop"]) : null,
        quantity: int.parse(data["quantity"].toString()),
        total: int.parse(data["total"].toString()),
        dateTime: DateTime.fromMillisecondsSinceEpoch(data["created_at"]),
        updateTime: DateTime.fromMillisecondsSinceEpoch(data["updated_at"]),
        confirmedAt: data["confirmed_at"] != null
            ? DateTime.fromMillisecondsSinceEpoch(data["created_at"])
            : null,
        deliveredAt: data["delivered_at"] != null
            ? DateTime.fromMillisecondsSinceEpoch(data["updated_at"])
            : null,
        status: (data["status"] == 'PENDING')
            ? TransactionStatus.pending
            : (data['status'] == 'DELIVERED')
                ? TransactionStatus.delivered
                : (data['status'] == 'CANCELLED')
                    ? TransactionStatus.cancelled
                    : TransactionStatus.on_delivery,
      );

  Transaction copyWith({
    int id,
    Shop shop,
    Product product,
    User user,
    int quantity,
    int total,
    DateTime dateTime,
    DateTime updateTime,
    DateTime confirmedAt,
    DateTime deliveredAt,
    TransactionStatus status,
  }) {
    return Transaction(
        id: id ?? this.id,
        shop: shop ?? this.shop,
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        dateTime: dateTime ?? this.dateTime,
        updateTime: updateTime ?? this.updateTime,
        confirmedAt: confirmedAt ?? this.confirmedAt,
        deliveredAt: deliveredAt ?? this.deliveredAt,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  @override
  List<Object> get props => [
        id,
        product,
        user,
        shop,
        quantity,
        total,
        dateTime,
        updateTime,
        confirmedAt,
        deliveredAt,
        status
      ];
}

List<Transaction> mockTransactions = [
  Transaction(
      id: 1,
      shop: mockShops[1],
      product: mockProducts[1],
      quantity: 10,
      total: (mockProducts[1].price * 10).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.on_delivery,
      user: mockUser),
  Transaction(
      id: 2,
      shop: mockShops[2],
      product: mockProducts[2],
      quantity: 7,
      total: (mockProducts[2].price * 7).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.delivered,
      user: mockUser),
  Transaction(
      id: 3,
      shop: mockShops[3],
      product: mockProducts[3],
      quantity: 5,
      total: (mockProducts[3].price * 5).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.cancelled,
      user: mockUser),
  Transaction(
      id: 4,
      shop: mockShops[1],
      product: mockProducts[1],
      quantity: 10,
      total: (mockProducts[1].price * 10).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.on_delivery,
      user: mockUser),
  Transaction(
      id: 5,
      shop: mockShops[2],
      product: mockProducts[2],
      quantity: 7,
      total: (mockProducts[2].price * 7).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.delivered,
      user: mockUser),
  Transaction(
      id: 6,
      shop: mockShops[3],
      product: mockProducts[3],
      quantity: 5,
      total: (mockProducts[3].price * 5).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.cancelled,
      user: mockUser),
  Transaction(
      id: 7,
      shop: mockShops[1],
      product: mockProducts[1],
      quantity: 10,
      total: (mockProducts[1].price * 10).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.on_delivery,
      user: mockUser),
  Transaction(
      id: 8,
      shop: mockShops[2],
      product: mockProducts[2],
      quantity: 7,
      total: (mockProducts[2].price * 7).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.delivered,
      user: mockUser),
  Transaction(
      id: 9,
      shop: mockShops[3],
      product: mockProducts[3],
      quantity: 5,
      total: (mockProducts[3].price * 5).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.cancelled,
      user: mockUser),
  Transaction(
      id: 10,
      shop: mockShops[1],
      product: mockProducts[1],
      quantity: 10,
      total: (mockProducts[1].price * 10).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.on_delivery,
      user: mockUser),
  Transaction(
      id: 11,
      shop: mockShops[2],
      product: mockProducts[2],
      quantity: 7,
      total: (mockProducts[2].price * 7).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.delivered,
      user: mockUser),
  Transaction(
      id: 12,
      shop: mockShops[3],
      product: mockProducts[3],
      quantity: 5,
      total: (mockProducts[3].price * 5).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.cancelled,
      user: mockUser),
  Transaction(
      id: 13,
      shop: mockShops[1],
      product: mockProducts[1],
      quantity: 10,
      total: (mockProducts[1].price * 10).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.on_delivery,
      user: mockUser),
  Transaction(
      id: 14,
      shop: mockShops[2],
      product: mockProducts[2],
      quantity: 7,
      total: (mockProducts[2].price * 7).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.delivered,
      user: mockUser),
  Transaction(
      id: 15,
      shop: mockShops[3],
      product: mockProducts[3],
      quantity: 5,
      total: (mockProducts[3].price * 5).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.cancelled,
      user: mockUser),
  Transaction(
      id: 16,
      shop: mockShops[1],
      product: mockProducts[1],
      quantity: 10,
      total: (mockProducts[1].price * 10).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.on_delivery,
      user: mockUser),
  Transaction(
      id: 17,
      shop: mockShops[2],
      product: mockProducts[2],
      quantity: 7,
      total: (mockProducts[2].price * 7).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.delivered,
      user: mockUser),
  Transaction(
      id: 18,
      shop: mockShops[3],
      product: mockProducts[3],
      quantity: 5,
      total: (mockProducts[3].price * 5).round() + 50000,
      dateTime: DateTime.now(),
      status: TransactionStatus.cancelled,
      user: mockUser)
];
