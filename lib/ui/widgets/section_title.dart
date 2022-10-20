part of 'widgets.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    this.isColor = false,
    this.all,
    this.sizeTitle = 24,
    this.defaultMargin = 24,
  }) : super(key: key);

  final String title;
  final double defaultMargin;
  final bool all;
  final double sizeTitle;
  final bool isColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (isColor) ? Colors.white : Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto().copyWith(
              fontSize: sizeTitle,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
