part of 'shared.dart';

void saveUserData({String email, String password, String token}) async {
  final _storage = const FlutterSecureStorage();
  _storage.write(key: 'email', value: email);
  _storage.write(key: 'password', value: password);
}

void removeUserData() async {
  final _storage = const FlutterSecureStorage();
  _storage.delete(key: 'email');
  _storage.delete(key: 'token');
}

void saveToken(String token) async {
  final _storage = const FlutterSecureStorage();
  _storage.write(key: 'token', value: token);
}

String capitalize(String string) {
  return "${string[0].toUpperCase()}${string.substring(1)}";
}

String tokenAPI =
    "aqnXBEi7KgPCMOP2qiOslLEd6u8Q2jQVFaYnlYQdtzLEVLtu0fRqTWZiPB1g";

// String baseURLAPI = 'http://10.0.2.2:3000/api';
String baseURLAPI = 'https://dev.tumbaspedia.my.id/api';

Color mainColor = "032339".toColor();
Color greyColor = "8D92A3".toColor();
Color secondaryColor = "FFC700".toColor();
const kSecondaryColor = Color(0xFF979797);
const kPrimaryLightColor = Color(0xFFFFECDF);

Widget loadingIndicator = Center(
    child: Container(color: Colors.white, child: CircularProgressIndicator()));

TextStyle redFontStyle = GoogleFonts.poppins().copyWith(color: Colors.red);
TextStyle orangeFontStyle =
    GoogleFonts.poppins().copyWith(color: Colors.orange);
TextStyle greenFontStyle = GoogleFonts.poppins().copyWith(color: Colors.green);
TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle greyFontStyle12 =
    GoogleFonts.poppins().copyWith(color: greyColor, fontSize: 12);
TextStyle greyFontStyle13 =
    GoogleFonts.poppins().copyWith(color: greyColor, fontSize: 13);
TextStyle blackFontStyle = GoogleFonts.poppins().copyWith(color: Colors.black);
TextStyle blackFontStyle1 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.poppins().copyWith(color: Colors.black);
TextStyle blackFontStyle12 =
    GoogleFonts.poppins().copyWith(color: Colors.black, fontSize: 12);
TextStyle whiteFontStyle = GoogleFonts.poppins().copyWith(color: Colors.white);
TextStyle whiteFontStyle1 = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle3 = GoogleFonts.poppins().copyWith(color: Colors.white);
TextStyle whiteFontStyle12 =
    GoogleFonts.poppins().copyWith(color: Colors.white, fontSize: 12);
TextStyle orangeFontStyle2 = GoogleFonts.poppins().copyWith(
    color: Colors.orange,
    fontSize: defaultFontSize,
    fontWeight: FontWeight.bold);
TextStyle hintStyle = GoogleFonts.poppins().copyWith(
  color: Color(0xFF666666),
  fontSize: defaultFontSize,
);

TextStyle textListStyle = blackFontStyle2.copyWith(fontSize: 15);

TextStyle sectionTitleStyle = GoogleFonts.poppins().copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle titleListStyle = GoogleFonts.poppins().copyWith(
  color: Colors.black,
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

String getFormatRupiah(int price, bool isFull) {
  if (price > 999999 && !isFull) {
    return 'Rp. ' + formatRupiah(price);
  }
  return NumberFormat.currency(
          locale: 'id-ID', symbol: 'Rp. ', decimalDigits: 0)
      .format(price);
}

String formatRupiah(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)} Ribu";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)} Ribu";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)} Juta";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)} Miliar";
  } else {
    return num.toString();
  }
}

String formatNumber(num) {
  if (num > 999 && num < 99999) {
    return "${(num / 1000).toStringAsFixed(1)} rb";
  } else if (num > 99999 && num < 999999) {
    return "${(num / 1000).toStringAsFixed(0)} rb";
  } else if (num > 999999 && num < 999999999) {
    return "${(num / 1000000).toStringAsFixed(1)} jt";
  } else if (num > 999999999) {
    return "${(num / 1000000000).toStringAsFixed(1)} m";
  } else {
    return num.toString();
  }
}

String convertDate(DateTime dateTime, bool isFull) {
  if (isFull) {
    return DateFormat('EEEE, d MMM, yyyy').format(dateTime);
  } else {
    return DateFormat('EE, d MMM, yyyy').format(dateTime);
  }
}

String convertTime(DateTime dateTime) {
  DateFormat dateFormat = DateFormat('').add_jms();
  return dateFormat.format(dateTime);
}

bool containsIgnoreCase(String firstString, String secondString) {
  firstString = firstString.toLowerCase();
  return firstString.contains(secondString) ? true : false;
}

Widget forgotPassword() {
  return Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
        onTap: () {
          Get.to(
            () => ForgotPasswordPage(),
          );
        },
        child: Text("Lupa password?", style: blackFontStyle)),
  );
}

void snackBar(String title, String subtitle, String type) {
  Get.snackbar(
    "",
    "",
    backgroundColor: type == 'success'
        ? "4A934A".toColor()
        : type == 'error'
            ? "D9435E".toColor()
            : type == 'warning'
                ? "#fff3cd".toColor()
                : Colors.white,
    icon: Icon(
        type == 'success'
            ? MdiIcons.checkCircleOutline
            : type == 'error'
                ? MdiIcons.closeCircleOutline
                : MdiIcons.alertCircleOutline,
        color:
            type == 'success' || type == 'error' ? Colors.white : Colors.black),
    titleText: Text(
      title,
      style: GoogleFonts.poppins(
          color: type == 'success' || type == 'error'
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      subtitle,
      style: GoogleFonts.poppins(
          color: type == 'success' || type == 'error'
              ? Colors.white
              : Colors.black),
    ),
  );
}

void displayBottomSheet(BuildContext context, Widget widget, double sizeHeight,
    bool isPaddingBottom) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        // <-- for border radius
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              padding: isPaddingBottom
                  ? EdgeInsets.symmetric(vertical: 26, horizontal: 16)
                  : EdgeInsets.only(top: 26, left: 16, right: 16),
              height: MediaQuery.of(context).size.height * (sizeHeight ??= 0.4),
              child: widget);
        });
      });
}

String numberFormatDecimal(int number) {
  var formatter = NumberFormat('###,###');
  return formatter.format(number);
}

Row iconText(IconData icon, String title, double iconSize, Color iconColor,
    TextStyle textStyle, bool isExpanded) {
  return Row(children: [
    Icon(
      icon,
      size: iconSize ??= defaultIconSize,
      color: iconColor ??= secondaryColor,
    ),
    const SizedBox(width: 4),
    isExpanded
        ? Expanded(child: Text(title, style: textStyle ??= greyFontStyle12))
        : Text(title, style: textStyle ??= greyFontStyle12),
  ]);
}

Row productBottomSheet(BuildContext context, String imageUrl, String name,
    String price, String textRight) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CachedNetworkImage(
            imageBuilder: (context, imageProvider) => Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
            repeat: ImageRepeat.repeat,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 198,
                child: Text(
                  name,
                  style: blackFontStyle2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              price != null
                  ? Text(
                      price,
                      style: textListStyle.copyWith(fontSize: 13),
                    )
                  : SizedBox()
            ],
          )
        ],
      ),
      Flexible(
        child: Text(
          textRight,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: textListStyle.copyWith(fontSize: 13),
        ),
      )
    ],
  );
}

const double defaultMargin = 24;
const double defaultFontSize = 15;
const double defaultIconSize = 17;
