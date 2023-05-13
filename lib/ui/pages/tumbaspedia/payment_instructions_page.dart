part of '../pages.dart';

class PaymentInstructionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return GeneralPage(
      title: 'Pembayaran',
      subtitle: 'Cara melakukan pembayaran',
      onBackButtonPressed: () {
        Get.back();
      },
      child: CardAccordion(
          title: "Tata Cara Memesan Produk UMKM", text: caraMemesan),
    );
  }
}
