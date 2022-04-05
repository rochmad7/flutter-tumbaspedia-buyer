part of 'pages.dart';

class SuccessOrderPage extends StatelessWidget {
  final Transaction transaction;

  SuccessOrderPage({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IllustrationPage(
          title: "Hore!",
          subtitle:
              "Pesananmu telah dibuat\nTunggu sebentar selagi\npesananmu dipersiapkan",
          picturePath: bike,
          buttonTap1: () {
            context
                .read<ProductCubit>()
                .getProducts(null, null, 10, null, null);
            context.read<TransactionCubit>().getTransactions(null);
            Get.offAll(() => MainPage(
                  initialPage: 2,
                ));
          },
          buttonTitle1: 'Pesan Produk Lain',
          buttonTap2: () {
            context
                .read<ProductCubit>()
                .getProducts(null, null, 10, null, null);
            context.read<TransactionCubit>().getTransactions(null);
            Get.to(() => TransactionDetailsPage(
                transaction: transaction,
                press: () {
                  Get.off(() => MainPage(initialPage: 3));
                }));
          },
          buttonTitle2: 'Lihat Pesanan Saya',
        ));
  }
}
