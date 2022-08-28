part of 'pages.dart';

class PaymentMethodPage extends StatelessWidget {
  final Transaction transaction;

  PaymentMethodPage({this.transaction});

  @override
  Widget build(BuildContext context) {
    // String type = (transaction.product.category.id == 3) ? "jasa" : "barang";
    return Scaffold(
        backgroundColor: Colors.white,
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
          // buttonTap1: () {
          //   Get.to(() =>SuccessOrderPage(transaction: transaction));
          // },
          // buttonTitle1: 'Lanjutkan',
        ));
  }
}
