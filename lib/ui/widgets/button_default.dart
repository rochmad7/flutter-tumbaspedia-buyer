part of 'widgets.dart';

class ButtonDefault extends StatelessWidget {
  final Function press;
  final String title;
  final Color color;
  final bool isLoading;
  ButtonDefault({this.press, this.isLoading = false, this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF2F3F7)),
      width: double.infinity,
      child: isLoading
          ? loadingIndicator
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15.0),
                primary: color != null ? color : mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    side: BorderSide(color: mainColor)),
              ),
              onPressed: press,
              child: Text(
                title,
                style: GoogleFonts.roboto().copyWith(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}

class ButtonIconDefault extends StatelessWidget {
  final Function press;
  final String title;
  final Color color;
  final double height;
  final bool isFullWidth;
  final bool isLoading;
  final bool isWhiteColor;
  final EdgeInsetsGeometry margin;
  final IconData icon;
  final double sizeIcon;
  final double sizeText;
  ButtonIconDefault({
    @required this.press,
    @required this.icon,
    this.margin,
    this.height = 50,
    this.isFullWidth = true,
    this.isWhiteColor = true,
    this.isLoading = false,
    @required this.title,
    this.color,
    this.sizeIcon,
    this.sizeText = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin != null
          ? margin
          : EdgeInsets.symmetric(horizontal: defaultMargin),
      height: height,
      width: isFullWidth ? double.infinity : null,
      child: isLoading
          ? loadingIndicator
          : ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: color != null ? color : mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              icon: Icon(
                icon,
                size: sizeIcon != null ? sizeIcon : null,
                color: isWhiteColor ? Colors.white : mainColor,
              ),
              onPressed: press,
              label: Text(
                title,
                style: isWhiteColor
                    ? whiteFontStyle3.copyWith(
                        fontWeight: FontWeight.w700, fontSize: sizeText)
                    : blackFontStyle3.copyWith(
                        fontWeight: FontWeight.w700, fontSize: sizeText),
              ),
            ),
    );
  }
}
