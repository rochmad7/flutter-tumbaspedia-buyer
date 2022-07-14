import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tumbaspedia/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/pages/pages.dart';
// import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _storage = const FlutterSecureStorage();
  String password = '';
  String email = '';
  String token = '';
  email = await _storage.read(key: 'email');
  password = await _storage.read(key: 'password');
  token = await _storage.read(key: 'token');
  runApp(MyApp(
    email: email,
    password: password,
    token: token,
  ));
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  final String email;
  final String password;
  final String token;

  MyApp({this.email = '', this.password = '', this.token = ''});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          email == '' && password == '' && token == ''
              ? BlocProvider(create: (_) => UserCubit()..userInitial())
              : BlocProvider(
                  create: (_) => UserCubit()..signIn(email, password, true)),
          BlocProvider(create: (_) => CategoryCubit()..getCategories(null)),
          BlocProvider(
              create: (_) => ShopCubit()..getShops(null, null, 10, null)),
          BlocProvider(
              create: (_) =>
                  ProductCubit()..getProducts(null, null, 10, null, null)),
          email == '' && password == '' && token == ''
              ? BlocProvider(create: (_) => TransactionCubit())
              : BlocProvider(
                  create: (_) => TransactionCubit()..getTransactions(null)),
          BlocProvider(create: (_) => PhotoCubit()),
          // BlocProvider(create: (_) => RatingCubit()),
          BlocProvider(create: (_) => SliderCubit()..getSliders(0, 8)),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Tumbaspedia",
          home: MainPage(),
        ),
      ),
    );
  }
}
