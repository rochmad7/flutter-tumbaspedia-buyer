part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signIn(
      String email, String password,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + '/auth/login';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        removeUserData();
        return ApiReturnValue(
            message: 'Email atau password salah', error: data['errors']);
      }

      // User.token = data['data']['access_token'];
      User value = User.fromJson(data['data']['user']);
      removeUserData();
      saveUserData(email: email, password: password);
      saveToken(data['data']['access_token']);

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

  static Future<ApiReturnValue<bool>> forgotPassword(String email,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + '/auth/send-reset-password';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(<String, String>{'email': email}));

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['errors']);
      }

      return ApiReturnValue(
          message: data['message'].toString(), error: null);
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

  static Future<ApiReturnValue<User>> changePassword(
      String oldPassword, String newPassword, String confPassword,
      {http.Client client}) async {
    try {
      if (newPassword != confPassword) {
        return ApiReturnValue(
            message: 'Password baru dan konfirmasi password tidak sama', isException: true);
      }
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final token = await _storage.read(key: 'token');

      String url = baseURLAPI + '/users/change-password';

      var response = await client.patch(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String, String>{
            'old_password': oldPassword,
            'new_password': newPassword,
          }));

      var data = jsonDecode(response.body);
      print(data);
      if (data['errors'] != null) {
        print(data['message']);
        return ApiReturnValue(
            message: data['message'],
            error: data['errors'], isException: true);
      }

      // User.token = data['data']['access_token'];
      User user = User.fromJson(data['data']['user']);
      // saveUserData(email: user.email, password: newPassword, token: User.token);
      return ApiReturnValue(value: user);
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

  static Future<ApiReturnValue<User>> signUp(User user, String password,
      {File pictureFile, http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + '/auth/register';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(<String, String>{
            'name': user.name,
            'email': user.email,
            'password': password,
            'phone_number': user.phoneNumber
          }));

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
      }

      User value = User.fromJson(data['user']);
      // User.token = data['data']['access_token'];
      // removeUserData();
      saveUserData(email: user.email, password: password);
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

  static Future<ApiReturnValue<User>> getMyProfile({http.Client client}) async {
    try {
      client ??= http.Client();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'user';

      var response = await client.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI,
        "Authorization": "Bearer ${prefs.getString('token')}"
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      User value = User.fromJson(data['data']);

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

  static Future<ApiReturnValue<User>> update(User user,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      user ??= User();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'user';
      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('token')}"
          },
          body: jsonEncode(<String, dynamic>{
            'name': user.name,
            'address': user.address,
            'phoneNumber': user.phoneNumber
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      User value = User.fromJson(data['data']);

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

  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile,
      {http.MultipartRequest request}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'user/photo';
      var uri = Uri.parse(url);

      if (request == null) {
        request = http.MultipartRequest("POST", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Token"] = tokenAPI
          ..headers["Authorization"] = "Bearer ${prefs.getString('token')}";
      }

      var multipartFile =
          await http.MultipartFile.fromPath('file', pictureFile.path);
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);

        String imagePath = data['data'][0];

        return ApiReturnValue(value: imagePath);
      } else {
        return ApiReturnValue(message: 'Uploading Profile Picture Failed');
      }
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

  static Future<ApiReturnValue<User>> logOut({http.Client client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'logout';

      var response = await client.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Token": tokenAPI,
          "Authorization": "Bearer ${prefs.getString('token')}"
        },
      );
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      removeUserData();

      return ApiReturnValue();
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
