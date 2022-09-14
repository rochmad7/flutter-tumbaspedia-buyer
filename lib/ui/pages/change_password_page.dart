part of 'pages.dart';

class ChangePasswordPage extends StatefulWidget {
  final User user;

  ChangePasswordPage({this.user});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  bool isLoading = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
  Map<String, dynamic> error;

  @override
  void initState() {
    super.initState();
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      onBackButtonPressed: () {
        Get.back();
      },
      title: 'Ubah Password',
      subtitle: 'Ubah Password Akun Anda',
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 26,
            ),
            LabelFormField(
              label: "Password Lama Anda",
            ),
            TextFieldDefault(
                suffixIcon: () => _toggle1(),
                icon: Icons.lock_outline,
                controller: oldPasswordController,
                isObscureText: _obscureText1,
                isSuffixIcon: true,
                hintText: "Password Lama"),
            TextDanger(error: error, param: "old_password"),
            SizedBox(
              height: 26,
            ),
            LabelFormField(
              label: "Password Baru",
            ),
            TextFieldDefault(
                suffixIcon: () => _toggle2(),
                icon: Icons.lock_outline,
                controller: newPasswordController,
                isObscureText: _obscureText2,
                isSuffixIcon: true,
                hintText: "Password Baru"),
            TextDanger(error: error, param: "new_password"),
            LabelFormField(
              label: "Konfirmasi Password Baru",
            ),
            TextFieldDefault(
                suffixIcon: () => _toggle3(),
                icon: Icons.lock_outline,
                controller: confPasswordController,
                isObscureText: _obscureText3,
                isSuffixIcon: true,
                hintText: "Konfirmasi Password"),
            TextDanger(error: error, param: "confirm_password"),
            SizedBox(height: 15),
            ButtonDefault(
              isLoading: isLoading,
              title: "Ubah Password",
              press: () async {
                setState(() {
                  isLoading = true;
                });

                if (oldPasswordController.text.isEmpty ||
                    newPasswordController.text.isEmpty ||
                    confPasswordController.text.isEmpty) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar('Gagal ubah password', 'Semua field harus diisi',
                      'error');
                  return;
                } else if (newPasswordController.text !=
                    confPasswordController.text) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar(
                      'Gagal ubah password', 'Password tidak sama', 'error');
                  return;
                }

                await context.read<UserCubit>().changePassword(
                    oldPasswordController.text,
                    newPasswordController.text,
                    confPasswordController.text);
                UserState state = context.read<UserCubit>().state;

                if (state is UserLoaded) {
                  setState(() {
                    error = null;
                    isLoading = false;
                  });
                  snackBar(
                      "Berhasil", "Password Anda berhasil diubah", 'success');
                } else {
                  context.read<UserCubit>().getMyProfile();
                  snackBar(
                      "Gagal", (state as UserLoadingFailed).message, 'error');
                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    isLoading = false;
                  });
                }
              },
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
