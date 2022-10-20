part of 'widgets.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(100),
              ),
              // child: Image.network(icon),
              child: CachedNetworkImage(
                imageUrl: icon,
                color: mainColor,
                // placeholder: (context, url) => Center(
                //   child: CircularProgressIndicator(),
                // ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              // child: Image.asset("assets/images/default.png"),
            ),
            SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto().copyWith(fontSize: 13, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
