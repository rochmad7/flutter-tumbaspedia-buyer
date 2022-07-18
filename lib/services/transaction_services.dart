part of 'services.dart';

class TransactionServices {
  static Future<ApiReturnValue<List<Transaction>>> getTransactions(int limit,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final token = await _storage.read(key: 'token');

      String url = baseURLAPI + '/transactions';
      if (limit != null) {
        url = url + '?limit=' + limit.toString();
      }

      var response = await client.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
      }

      List<Transaction> transactions = (data['data'] as Iterable)
          .map((e) => Transaction.fromJson(e))
          .toList();

      return ApiReturnValue(value: transactions);
    } on SocketException {
      return ApiReturnValue(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValue(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValue(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValue(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValue<Transaction>> submitTransaction(
      Transaction transaction,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      final _storage = const FlutterSecureStorage();
      final token = await _storage.read(key: 'token');
      String url = baseURLAPI + '/transactions';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String, dynamic>{
            'shop_id': transaction.product.shop.id,
            'product_id': transaction.product.id,
            'user_id': transaction.user.id,
            'quantity': transaction.quantity,
            'total': transaction.total,
            'status': "PENDING",
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 201) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['errors']);
      }

      Transaction value = Transaction.fromJson(data['data']);

      return ApiReturnValue(value: value);
    } on SocketException {
      return ApiReturnValue(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValue(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValue(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValue(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValue<Transaction>> confirmDelivered(
      Transaction transaction,
      {http.Client client}) async {
    // try {
    client ??= http.Client();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = baseURLAPI + 'transaction/confirmdelivered';

    var response = await client.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Token": tokenAPI,
          "Authorization": "Bearer ${prefs.getString('token')}"
        },
        body: jsonEncode(<String, dynamic>{
          'transaction_id': transaction.id.toString(),
        }));

    var data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      return ApiReturnValue(
          message: data['data']['message'].toString(),
          error: data['data']['error']);
    }

    Transaction value = Transaction.fromJson(data['data']);

    return ApiReturnValue(value: value);
    // } on SocketException {
    //   return ApiReturnValue(message: socketException, isException: true);
    // } on HttpException {
    //   return ApiReturnValue(message: httpException, isException: true);
    // } on FormatException {
    //   return ApiReturnValue(message: formatException, isException: true);
    // } catch (e) {
    //   return ApiReturnValue(message: e.toString(), isException: true);
    // }
  }
}
