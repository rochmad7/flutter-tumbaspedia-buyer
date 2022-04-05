part of 'widgets.dart';

class CustomAlert extends StatelessWidget {
  final IconData icon;
  final bool isDistance;
  final String title;
  final String type;
  final bool isCenter;
  CustomAlert(
      {this.icon,
      this.isCenter = true,
      this.isDistance = true,
      this.title,
      this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 16, horizontal: isCenter ? 0 : 12),
      margin: isDistance ? EdgeInsets.symmetric(horizontal: 16) : null,
      color: (type == 'warning')
          ? "#fff3cd".toColor()
          : (type == 'success')
              ? "#4A934A".toColor()
              : (type == 'error')
                  ? "#D9435E".toColor()
                  : "#fff3cd".toColor(),
      width: double.infinity,
      child: Row(
          mainAxisAlignment:
              isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(icon,
                color: type == 'warning' || type == null
                    ? Colors.black
                    : Colors.white),
            SizedBox(width: 10),
            Flexible(
              child: Text(title,
                  style: type == 'warning' || type == null
                      ? blackFontStyle3
                      : whiteFontStyle3),
            )
          ]),
    );
  }
}

class CustomIllustration extends StatelessWidget {
  final String picturePath;
  final String title;
  final String subtitle;
  final bool isIllustration;
  final double marginBottom;
  final double sizeTitle;
  final double sizeSubTitle;

  CustomIllustration(
      {this.marginBottom = 30,
      this.sizeSubTitle = 16,
      this.isIllustration = true,
      this.sizeTitle = 30,
      this.picturePath,
      this.title,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isIllustration
              ? Container(
                  width: 150,
                  height: 150,
                  margin: EdgeInsets.only(bottom: marginBottom),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(picturePath))),
                )
              : SizedBox(),
          Text(
            title,
            style: blackFontStyle3.copyWith(fontSize: sizeTitle),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: greyFontStyle.copyWith(
                fontWeight: FontWeight.w400, fontSize: sizeSubTitle),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
