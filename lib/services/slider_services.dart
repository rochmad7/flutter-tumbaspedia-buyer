part of 'services.dart';

class SliderServices {
  static Future<ApiReturnValue<List<Slider>>> getSliders(int start, int limit,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url;
      start ??= 0;

      url = baseURLAPI + 'slider?start=' + start.toString();
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

      List<Slider> photos = (data['data']['data'] as Iterable)
          .map((e) => Slider.fromJson(e))
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
}
