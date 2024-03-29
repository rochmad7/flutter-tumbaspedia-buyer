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
// String baseURLAPI = 'https://dev.tumbaspedia.my.id/api';
String baseURLAPI = 'https://tumbaspedia-dev.fly.dev/api';
// String baseURLAPI = 'https://tumbaspedia.fly.dev/api';

// Color mainColor = "032339".toColor();
Color mainColor =Color(0xff541690);
Color greyColor = "8D92A3".toColor();
Color secondaryColor = "FFC700".toColor();
Color mainAccentColor = Color(0xff541690);
const kSecondaryColor = Color(0xFF979797);
const kPrimaryLightColor = Color(0xFFFFECDF);

Widget loadingIndicator = Center(
    child: Container(color: Colors.white, child: CircularProgressIndicator()));

TextStyle redFontStyle = GoogleFonts.roboto().copyWith(color: Colors.red);
TextStyle orangeFontStyle =
    GoogleFonts.roboto().copyWith(color: Colors.orange);
TextStyle greenFontStyle = GoogleFonts.roboto().copyWith(color: Colors.green);
TextStyle greyFontStyle = GoogleFonts.roboto().copyWith(color: greyColor);
TextStyle greyFontStyle12 =
    GoogleFonts.roboto().copyWith(color: greyColor, fontSize: 12);
TextStyle greyFontStyle13 =
    GoogleFonts.roboto().copyWith(color: greyColor, fontSize: 13);
TextStyle blackFontStyle = GoogleFonts.roboto().copyWith(color: Colors.black, fontSize: 14);
TextStyle blackFontStyle1 = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyle2 = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.roboto().copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle blackFontStyle12 =
    GoogleFonts.roboto().copyWith(color: Colors.black, fontSize: 12);
TextStyle whiteFontStyle = GoogleFonts.roboto().copyWith(color: Colors.white);
TextStyle whiteFontStyle1 = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle2 = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle whiteFontStyle3 = GoogleFonts.roboto().copyWith(color: Colors.white);
TextStyle whiteFontStyle12 =
    GoogleFonts.roboto().copyWith(color: Colors.white, fontSize: 12);
TextStyle orangeFontStyle2 = GoogleFonts.roboto().copyWith(
    color: Colors.orange,
    fontSize: defaultFontSize,
    fontWeight: FontWeight.bold);
TextStyle hintStyle = GoogleFonts.roboto().copyWith(
  color: Color(0xFF666666),
  fontSize: defaultFontSize,
);

TextStyle textListStyle = blackFontStyle2.copyWith(fontSize: 15);

TextStyle sectionTitleStyle = GoogleFonts.roboto().copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle titleListStyle = GoogleFonts.roboto().copyWith(
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
    return DateFormat('EEEE, d MMM yyyy', 'id_ID').format(dateTime);
  } else {
    return DateFormat('EE, d MMM yyyy', 'id_ID').format(dateTime);
  }
}

String convertTime(DateTime dateTime) {
  String date = DateFormat('HH:mm', 'id_ID').format(dateTime);

  return date + ' WIB';
}

bool containsIgnoreCase(String firstString, String secondString) {
  firstString = firstString.toLowerCase();
  return firstString.contains(secondString) ? true : false;
}

// convert string time value to TimeOfDay object
TimeOfDay parseTime(String timeString) {
  DateFormat dateFormat = DateFormat("HH:mm:ss");
  DateTime dateTime = dateFormat.parse(timeString);
  return TimeOfDay.fromDateTime(dateTime);
}

// check if shop is open
bool isShopOpen(DateTime currentTime, String openedAt, String closedAt) {
  TimeOfDay openTime = parseTime(openedAt);
  TimeOfDay closeTime = parseTime(closedAt);
  TimeOfDay currentTimeOfDay = TimeOfDay.fromDateTime(currentTime);

  // compare current time with opening and closing times
  int currentMinutes =
      currentTimeOfDay.hour * 60 + currentTimeOfDay.minute;
  int openMinutes = openTime.hour * 60 + openTime.minute;
  int closeMinutes = closeTime.hour * 60 + closeTime.minute;

  if (currentMinutes >= openMinutes && currentMinutes <= closeMinutes) {
    return true;
  } else {
    return false;
  }
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
        child: Text("Lupa kata sandi?", style: blackFontStyle)),
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
      style: GoogleFonts.roboto(
          color: type == 'success' || type == 'error'
              ? Colors.white
              : Colors.black,
          fontWeight: FontWeight.w600),
    ),
    messageText: Text(
      subtitle,
      style: GoogleFonts.roboto(
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
const double defaultFontSize = 18;
const double defaultIconSize = 17;
