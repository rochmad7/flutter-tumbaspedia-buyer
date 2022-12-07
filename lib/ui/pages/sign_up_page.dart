part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Daftar',
      subtitle: 'Silahkan daftar akun baru',
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            LabelFormField(
              label: "Nama Lengkap",
            ),
            TextFieldDefault(
                icon: Icons.person,
                controller: nameController,
                hintText: "Nama Lengkap"),
            TextDanger(error: error, param: "name"),
            SizedBox(height: 15),
            LabelFormField(
              label: "Email",
              example: "Contoh: tumbaspedia@gmail.com",
            ),
            TextFieldDefault(
                icon: Icons.mail_outline,
                controller: emailController,
                hintText: "Email"),
            TextDanger(error: error, param: "email"),
            SizedBox(height: 15),
            LabelFormField(
              label: "No HP",
              example: "Contoh: 0888888888",
            ),
            TextFieldDefault(
                icon: MdiIcons.phone,
                controller: phoneController,
                hintText: "No. HP"),
            TextDanger(error: error, param: "phoneNumber"),
            SizedBox(height: 15),
            LabelFormField(
              label: "Alamat",
            ),
            TextFieldDefault(
                icon: MdiIcons.selectPlace,
                controller: addressController,
                isMaxLines: true,
                maxLines: 4),
            TextDanger(error: error, param: "address"),
            SizedBox(height: 15),
            LabelFormField(
              label: "Kata Sandi",
              example: "Minimal 8 karakter",
            ),
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
              title: "Daftar",
              press: () async {
                setState(() {
                  isLoading = true;
                });

                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar("Pendaftaran gagal", "Silahkan lengkapi data Anda",
                      "error");
                  return;
                } else if (!emailController.text.isEmail ||
                    !phoneController.text.isPhoneNumber ||
                    passwordController.text.length < 6) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar("Pendaftaran gagal",
                      "Data yang Anda masukkan tidak valid", "error");
                  return;
                }

                User user = User(
                    name: nameController.text,
                    email: emailController.text,
                    address: addressController.text,
                    phoneNumber: phoneController.text);

                await context
                    .read<UserCubit>()
                    .signUp(user, passwordController.text);

                UserState state = context.read<UserCubit>().state;

                if (state is UserLoaded) {
                  setState(() {
                    isLoading = false;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();

                  // context.read<TransactionCubit>().getTransactions(null);
                  // context
                  //     .read<ProductCubit>()
                  //     .getProducts(null, null, 10, null, null);
                  // context.read<ShopCubit>().getShops(null, null, 10, null);
                  // context.read<CategoryCubit>().getCategories(null);
                  Get.offAll(() => WaitingRegisterConfirmation());
                } else {
                  snackBar("Pendaftaran akun gagal",
                      (state as UserLoadingFailed).message, 'error');
                  setState(() {
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
                title: "Sudah punya akun? ",
                subtitle: "Masuk",
                press: () => {
                      Get.to(
                        () => SignInPage(),
                      )
                    }),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class TextUnderButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function press;
  final TextStyle subtitleStyle;

  TextUnderButton({this.title, this.subtitleStyle, this.subtitle, this.press});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              title,
              style: greyFontStyle,
            ),
          ),
          InkWell(
            onTap: press,
            child: Container(
              child: Text(
                subtitle,
                style: subtitleStyle != null ? subtitleStyle : orangeFontStyle2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
