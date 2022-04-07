part of '../pages.dart';

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Security',
      subtitle: 'Jaminan Keamanan',
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(),
    );
  }
}
