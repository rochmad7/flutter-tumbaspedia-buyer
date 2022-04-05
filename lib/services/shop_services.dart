part of 'services.dart';

class ShopServices {
  static Future<ApiReturnValue<List<Shop>>> getShops(
      int page, int start, int limit, String query,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      query ??= '';
      String url;

      url = baseURLAPI +
          'shop?page=' +
          page.toString() +
          '&start=' +
          start.toString() +
          '&search=' +
          query;
      if (limit != null) {
        url += '&limit=' + limit.toString();
      }

      var response = await client.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      List<Shop> shops = (data['data']['data'] as Iterable)
          .map((e) => Shop.fromJson(e))
          .toList();
      int length = data['data']['length'];

      return ApiReturnValue(value: shops, length: length);
    } on SocketException {
      return ApiReturnValue(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValue(message: 'Data tidak ditemukan', isException: true);
    } on FormatException {
      return ApiReturnValue(message: 'Format respon salah', isException: true);
    } catch (e) {
      return ApiReturnValue(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValue<int>> countShops(String query,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      String url;
      url = baseURLAPI + 'shop?count=true';
      if (query != null) {
        url += '&search=' + query;
      }

      var response = await client.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      int length = data['data'];

      return ApiReturnValue(length: length);
    } on SocketException {
      return ApiReturnValue(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValue(message: 'Data tidak ditemukan', isException: true);
    } on FormatException {
      return ApiReturnValue(message: 'Format respon salah', isException: true);
    } catch (e) {
      return ApiReturnValue(message: e.toString(), isException: true);
    }
  }
}
