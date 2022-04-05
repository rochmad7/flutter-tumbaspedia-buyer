part of 'widgets.dart';

class Illustration extends StatelessWidget {
  final String picturePath;
  final String title;
  final String subtitle;

  Illustration({this.picturePath, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 60),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            margin: EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(picturePath))),
                          ),
                          Text(
                            title,
                            style: blackFontStyle3.copyWith(fontSize: 30),
                          ),
                          Text(
                            subtitle,
                            style: greyFontStyle.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
