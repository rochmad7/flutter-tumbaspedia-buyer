part of 'pages.dart';

class CompleteProfilePage extends StatelessWidget {
  final Transaction transaction;

  CompleteProfilePage({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IllustrationPage(
          title: "Oops!",
          subtitle:
              "Silahkan lengkapi\nprofile Anda\nsebelum melakukan\npemesanan",
          picturePath: completeProfile,
          buttonTap1: () {
            context
                .read<ProductCubit>()
                .getProducts(null, null, 10, null, null);
            context.read<TransactionCubit>().getTransactions(null);
            Get.to(() => FormCompleteProfilePage(transaction: transaction));
          },
          buttonTitle1: 'Lengkapi Data Diri',
          buttonTap2: null,
          buttonTitle2: null,
        ));
  }
}
