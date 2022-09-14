part of 'pages.dart';

class WaitingRegisterConfirmation extends StatelessWidget {
  WaitingRegisterConfirmation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IllustrationPage(
          title: "Hore",
          // isBackHome: (shop.isValid) ? false : true,
          sizeTitle: 20,
          subtitle: "Pendaftaran berhasil, silakan cek email Anda ",
          picturePath: verification,
          buttonTap1: () {
            Get.offAll(() => SignInPage());
          },
          buttonTitle1: "Kembali",
        ));
  }
}
