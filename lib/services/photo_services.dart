part of 'services.dart';

class PhotoServices {
  static Future<ApiReturnValue<List<Photo>>> getPhotos(
      int start, int limit, int productId,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url;
      start ??= 0;

      if (productId == null) {
        url = baseURLAPI + '/product-pictures?start=' + start.toString();
      } else {
        url = baseURLAPI + '/product-pictures/' + productId.toString();
      }
      if (limit != null) {
        url += '&limit=' + limit.toString();
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

      List<Photo> photos = (data['data'] as Iterable)
          .map((e) => Photo.fromJson(e))
          .toList();

      return ApiReturnValue(value: photos);
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

  static Future<ApiReturnValue<List<Photo>>> getPhotosByProduct(Product product,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + 'product?product_id=' + product.id.toString();

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

      List<Photo> photos = (data['data'] as Iterable)
          .map((e) => Photo.fromJson(e))
          .toList();
      print(photos);
      print(data);

      return ApiReturnValue(value: photos);
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
