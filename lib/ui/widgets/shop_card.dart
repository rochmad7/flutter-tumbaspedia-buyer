part of 'widgets.dart';

class ShopCard extends StatelessWidget {
  final Function press;
  const ShopCard({
    Key key,
    @required this.shop,
    this.press,
  }) : super(key: key);

  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(
            left: defaultMargin, right: defaultMargin, top: 10, bottom: 10),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: press,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    offset: const Offset(2, 3),
                    blurRadius: 2.0),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: Stack(
                children: [
                  Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        // child: Container(
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: NetworkImage(shop.images),
                        //       fit: BoxFit.cover,
                        //       repeat: ImageRepeat.repeat,
                        //     ),
                        //   ),
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: shop.shopPicture,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => CardShimmer(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                      Container(
                        color: mainAccentColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                color: mainAccentColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 14),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shop.name,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.roboto().copyWith(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: secondaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      iconText(MdiIcons.cart, shop.totalProducts.toString() + " Produk",
                                          null, null, whiteFontStyle, true),
                                      SizedBox(height: 4),
                                      iconText(MdiIcons.mapMarker, shop.address,
                                          null, null, whiteFontStyle, true),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  shop.isOpen
                      ? SizedBox()
                      : Positioned(
                          top: 15,
                          left: 15,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
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
        ),
      ),
    );
  }
}
