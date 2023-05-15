part of 'widgets.dart';

class ShopItem extends StatelessWidget {
  final Function press;

  const ShopItem(
      {Key key,
      this.width = 140,
      this.aspectRetio = 1.02,
      this.defaultMargin = 24,
      @required this.shop,
      this.press})
      : super(key: key);

  final double width, aspectRetio, defaultMargin;
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.only(bottom: defaultMargin, left: defaultMargin),
        child: Container(
          width: 200,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl: shop.shopPicture,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => CardShimmer(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        repeat: ImageRepeat.repeat,
                        height: 140,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 6),
                    width: 200,
                    child: Text(
                      shop.name,
                      style: blackFontStyle2,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: iconText(
                        MdiIcons.shopping,
                        shop.totalProducts.toString() + " produk",
                        null,
                        null,
                        greyFontStyle,
                        true),
                  ),
                ],
              ),
              shop.isOpen
                  ? SizedBox()
                  : Positioned(
                      top: 15,
                      left: 15,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle, color: Colors.red),
                        alignment: Alignment.center,
                        child: Text("Tutup",
                            style: whiteFontStyle3.copyWith(fontSize: 10)),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
