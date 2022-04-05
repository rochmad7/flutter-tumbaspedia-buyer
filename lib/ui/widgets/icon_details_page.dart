part of 'widgets.dart';

class IconDetailsPage extends StatelessWidget {
  final Function press;
  IconDetailsPage({this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: press,
              child: Container(
                padding: EdgeInsets.all(3),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black26),
                child: Image.asset('assets/icons/back_arrow_white.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Get.to(() => MainPage(initialPage: 0));
              },
              child: Container(
                padding: EdgeInsets.all(3),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black26),
                child: Icon(MdiIcons.home, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
