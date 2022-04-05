part of 'widgets.dart';

class ErrorValidation extends StatelessWidget {
  final String error;

  ErrorValidation({this.error});

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 10),
        color: "#fff3cd".toColor(),
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(MdiIcons.alert),
          SizedBox(width: 5),
          Flexible(
            child: Text(error, style: blackFontStyle3.copyWith(fontSize: 12)),
          )
        ]),
      );
    } else {
      return SizedBox();
    }
  }
}

class TextDanger extends StatelessWidget {
  final String param;
  final Map<String, dynamic> error;
  TextDanger({this.param, this.error});

  @override
  Widget build(BuildContext context) {
    if (error != null && error.containsKey(param)) {
      return Column(
          children: List<Widget>.generate(error[param].length, (index) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Text(
            error[param].length > 1
                ? '• ' + error[param][index]
                : '' + error[param][index],
            style: redFontStyle,
          ),
        );
      }));
    } else {
      return SizedBox();
    }
  }
}
