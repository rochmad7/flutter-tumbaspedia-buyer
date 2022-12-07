part of 'pages.dart';

class SignInPage extends StatefulWidget {
  final bool isRedirect;

  SignInPage({this.isRedirect = false});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // Initially password is obscure
  bool _obscureText = true;
  Map<String, dynamic> error;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoLogIn();
    });
    super.initState();
  }

  void _autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('email');
    final String password = prefs.getString('password');

    if (email != null) {
      setState(() {
        emailController.text = email;
        passwordController.text = password;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Masuk',
      subtitle: 'Masuk menggunakan akun Anda',
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => MainPage(
                      initialPage: 0,
                    ));
              },
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo/logo.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFieldDefault(
                icon: Icons.mail_outline,
                controller: emailController,
                hintText: "Email"),
            TextDanger(error: error, param: "email"),
            SizedBox(height: 8),
            forgotPassword(),
            SizedBox(height: 7),
            TextFieldDefault(
                suffixIcon: () => _toggle(),
                icon: Icons.lock_outline,
                controller: passwordController,
                isObscureText: _obscureText,
                isSuffixIcon: true,
                hintText: "Kata Sandi"),
            TextDanger(error: error, param: "password"),
            SizedBox(height: 15),
            ButtonDefault(
              isLoading: isLoading,
              title: "Masuk",
              press: () async {
                setState(() {
                  isLoading = true;
                });

                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar("Login gagal",
                      "Email dan kata sandi tidak boleh kosong", 'error');
                  return;
                } else if (!emailController.text.isEmail ||
                    passwordController.text.length < 6) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar("Login gagal", "Email atau kata sandi tidak valid",
                      "error");
                  return;
                }

                await context.read<UserCubit>().signIn(
                    emailController.text, passwordController.text, false);
                UserState state = context.read<UserCubit>().state;

                if (state is UserLoaded) {
                  setState(() {
                    isLoading = false;
                  });
                  context.read<TransactionCubit>().getTransactions(null);
                  context
                      .read<ProductCubit>()
                      .getProducts(null, null, 10, null, null);
                  context.read<ShopCubit>().getShops(null, null, 10, null);
                  context.read<CategoryCubit>().getCategories(null);
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (widget.isRedirect) {
                    Get.back();
                  } else {
                    Get.off(() => MainPage());
                  }
                } else {
                  snackBar("Login gagal", (state as UserLoadingFailed).message,
                      'error');

                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    isLoading = false;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
            ),
            SizedBox(
              height: 25,
            ),
            TextUnderButton(
                title: "Belum punya akun? ",
                subtitle: "Daftar",
                press: () => {
                      Get.to(
                        () => SignUpPage(),
                      )
                    }),
          ],
        ),
      ),
    );
  }
}
