part of 'pages.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic> error;
  String message;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      onBackButtonPressed: () async {
        // context.read<UserCubit>().getMyProfile(widget.user.id);
        Get.back();
      },
      title: 'Lupa Kata Sandi',
      subtitle: 'Reset Kata Sandi Anda Melalui Email',
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            message != null
                ? Column(
                    children: [
                      CustomAlert(
                          title: "Berhasil! \n" + message,
                          icon: MdiIcons.check,
                          type: 'success',
                          isDistance: false,
                          isCenter: false),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonDefault(
                          press: () {
                            Get.to(() => SignInPage());
                          },
                          title: "Lanjutkan Login",
                          color: mainColor),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Silakan masukkan email akun Anda. Kami akan mengirimkan tautan untuk mereset kata sandi Anda.",
                        style: blackFontStyle3.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LabelFormField(
                        label: "Email",
                      ),
                      TextFieldDefault(
                          icon: Icons.mail_outline,
                          controller: emailController,
                          hintText: "Email"),
                      TextDanger(error: error, param: "email"),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonDefault(
                        isLoading: isLoading,
                        title: "Reset Kata Sandi",
                        press: () async {
                          setState(() {
                            isLoading = true;
                          });

                          if (emailController.text.isEmpty) {
                            setState(() {
                              isLoading = false;
                            });
                            snackBar('Terjadi Kesalahan',
                                'Email tidak boleh kosong', 'error');
                            return;
                          } else if (!emailController.text.isEmail) {
                            setState(() {
                              isLoading = false;
                            });
                            snackBar('Terjadi Kesalahan', 'Email tidak valid',
                                'error');
                            return;
                          }

                          await context
                              .read<UserCubit>()
                              .forgotPassword(emailController.text);
                          UserState state = context.read<UserCubit>().state;

                          if (state is UserForgotPassword) {
                            setState(() {
                              error = null;
                              message = state.message;
                              isLoading = false;
                            });
                            snackBar(
                                "Berhasil",
                                "Link reset password berhasil dikirim",
                                'success');
                          } else {
                            snackBar(
                                "Gagal",
                                (state as UserForgotPasswordFailed).message,
                                'error');
                            setState(() {
                              error = (state as UserForgotPasswordFailed)
                                          .error !=
                                      null
                                  ? (state as UserForgotPasswordFailed).error
                                  : null;
                              message = null;
                              isLoading = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
