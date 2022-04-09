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
        width: 95,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: 55,
              width: 95,
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              // child: Image.network(icon),
              child: CachedNetworkImage(
                imageUrl: icon,
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
              style: GoogleFonts.poppins().copyWith(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
