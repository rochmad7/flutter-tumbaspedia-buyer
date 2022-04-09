part of 'services.dart';

class ProductServices {
  static Future<ApiReturnValue<List<Product>>> getProducts(String query,
      int start, int limit, int categoryId, int shopId, SortMethod sort,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      String url;
      query ??= '';
      start ??= 0;
      url =
          baseURLAPI + '/products?start=' + start.toString() + '&search=' + query;
      if (categoryId != null) {
        url += '&category=' + categoryId.toString();
      }
      if (shopId != null) {
        url += '&shop=' + shopId.toString();
      }
      if (limit != null) {
        url += '&limit=' + limit.toString();
      }
      if (sort == SortMethod.terbaru) {
        url += '&sort_by=datedesc';
      } else if (sort == SortMethod.terlaris) {
        url += '&sort_by=solddesc';
      } else if (sort == SortMethod.termurah) {
        url += '&sort_by=priceasc';
      }

      var response = await client.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['errors']);
      }

      List<Product> products = (data['data'] as Iterable)
          .map((e) => Product.fromJson(e))
          .toList();

      return ApiReturnValue(value: products);
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

  static Future<void> countProducts(int shopId, int categoryId, String query,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      String url;
      url = baseURLAPI + 'product?count=true';
      if (query != null) {
        url += '&search=' + query;
      }
      if (categoryId != null) {
        url += '&category_id=' + categoryId.toString();
      }
      if (shopId != null) {
        url += '&shop_id=' + shopId.toString();
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
      return ApiReturnValue(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValue(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValue(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValue<List<Product>>> getProductsByShop(Shop shop,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + '/products?shop=' + shop.id.toString();

      var response = await client.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
      }

      List<Product> products = (data['data'] as Iterable)
          .map((e) => Product.fromJson(e))
          .toList();

      print(data);

      return ApiReturnValue(value: products);
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
}
