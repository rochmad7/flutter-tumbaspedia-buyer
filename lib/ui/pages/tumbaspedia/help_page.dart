part of '../pages.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Bantuan',
      subtitle: 'Panduan penggunaan aplikasi',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Column(
        children: [
          CardAccordion(title: "Cara Memesan Produk UMKM", text: caraMemesan),
          CardAccordion(title: "Informasi tentang Status Pesanan", text: statusPesanan),
          CardAccordion(
              title: "Fungsi Tanda Notifikasi Merah",
              text: tandaMerah),
          CardAccordion(title: "Cara Membuat Akun", text: buatAkun),
          CardAccordion(title: "Bantuan Permasalahan", text: help),
        ],
      ),
    );
  }
}
