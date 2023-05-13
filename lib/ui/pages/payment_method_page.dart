part of 'pages.dart';

class PaymentMethodPage extends StatelessWidget {
  final Transaction transaction;

  PaymentMethodPage({this.transaction});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Container(
              padding: EdgeInsets.all(3),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: mainAccentColor,
              ),
              child: Icon(
                MdiIcons.arrowLeft,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
      body: IllustrationPage(
        title: "Berhasil!",
        subtitle:
            "Selesaikan pesananmu\ndengan menghubungi\npenjual untuk\nproses pembayaran",
        picturePath: payment,
        buttonTap1: () async => await launch(
          "https://wa.me/62" +
              transaction.shop.user.phoneNumber.allAfter("0") +
              "?text=[Pesan dari aplikasi Tumbaspedia] Halo Saya " +
              (context.read<UserCubit>().state as UserLoaded).user.name +
              " ingin memesan " +
              transaction.product.name +
              " di toko " +
              transaction.shop.name +
              " dengan jumlah " +
              transaction.quantity.toString() +
              " dan total harga " +
              getFormatRupiah(
                  transaction.quantity * transaction.product.price, true),
        ),
        buttonTitle1: 'Hubungi Penjual',
      ),
    ));
  }
}
