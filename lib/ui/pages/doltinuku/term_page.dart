part of '../pages.dart';

class TermPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Term & Service',
      subtitle: 'Syarat & Ketentuan',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(),
    );
  }
}
