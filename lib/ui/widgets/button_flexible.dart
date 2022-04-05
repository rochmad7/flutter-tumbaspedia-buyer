part of 'widgets.dart';

class ButtonFlexible extends StatelessWidget {
  final Function press;
  final String title;
  final IconData icon;
  final double marginTop;
  final Color color;
  ButtonFlexible(
      {this.press, this.marginTop = 0, this.icon, this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        width: double.infinity,
        height: 45,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: Icon(
            icon,
            color: Colors.white,
            size: 17,
          ),
          label: Text(title,
              style: whiteFontStyle3.copyWith(fontWeight: FontWeight.w500)),
          onPressed: press,
        ),
      ),
    );
  }
}
