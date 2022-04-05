part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signIn(
      String email, String password, bool hasToken,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'login4';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "HasToken": hasToken ? prefs.getString('token') : ''
          },
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      User.token = data['data']['access_token'];
      User value = User.fromJson(data['data']['user']);
      removeUserData();
      saveUserData(email: email, password: password, token: User.token);

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

      String url = baseURLAPI + 'forgotpassword';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI
          },
          body: jsonEncode(<String, String>{'email': email}));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      return ApiReturnValue(
          message: data['data']['message'].toString(), error: null);
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
      client ??= http.Client();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'changepassword';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('token')}"
          },
          body: jsonEncode(<String, String>{
            'oldpassword': oldPassword,
            'newpassword': newPassword,
            'confpassword': confPassword
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      User.token = data['data']['access_token'];
      User user = User.fromJson(data['data']['user']);
      saveUserData(email: user.email, password: newPassword, token: User.token);
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

      String url = baseURLAPI + 'register4';

      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI
          },
          body: jsonEncode(<String, String>{
            'name': user.name,
            'email': user.email,
            'password': password,
            'password_confirmation': password,
            'phoneNumber': user.phoneNumber
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      User.token = data['data']['access_token'];
      User value = User.fromJson(data['data']['user']);
      removeUserData();
      saveUserData(email: user.email, password: password, token: User.token);
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
