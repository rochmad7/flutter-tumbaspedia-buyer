part of 'widgets.dart';

class SectionBottom extends StatelessWidget {
  const SectionBottom({
    Key key,
    @required this.title,
    this.press,
    this.isColor = false,
    this.all,
    this.sizeTitle = 17,
    this.defaultMargin = 24,
  }) : super(key: key);

  final String title;
  final double defaultMargin;
  final GestureTapCallback press;
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
          all
              // ? GestureDetector(
              //     onTap: press,
              //     child: Container(
              //       // margin: EdgeInsets.only(right: 10),
              //       // decoration: BoxDecoration(
              //       //   borderRadius: BorderRadius.circular(8),
              //       //   color: Colors.orange[800],
              //       // ),
              //       child: Text(
              //         "Lihat Semua",
              //         style: GoogleFonts.roboto().copyWith(
              //           fontSize: 16.0,
              //           color: Colors.orange[800],
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   )
              ? ElevatedButton(
                  onPressed: press,
              style: ElevatedButton.styleFrom(
                primary: Colors.orange[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Lihat Semua'))
              : SizedBox(),
        ],
      ),
    );
  }
}
