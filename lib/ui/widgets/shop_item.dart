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
          height: 210,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 15,
                color: Colors.black12,
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    imageUrl: shop.images,
                    placeholder: (context, url) => CardShimmer(
                        isSymmetric: false, height: 140, isCircular: true),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    repeat: ImageRepeat.repeat,
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
                        MdiIcons.cart,
                        shop.totalProducts.toString() + " produk",
                        null,
                        null,
                        greyFontStyle,
                        true),
                  ),
                ],
              ),
              shop.status
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
