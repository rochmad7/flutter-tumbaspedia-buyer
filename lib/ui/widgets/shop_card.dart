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
            left: defaultMargin, right: defaultMargin, top: 8, bottom: 16),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: press,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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
                          imageUrl: shop.images,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => CardShimmer(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          repeat: ImageRepeat.repeat,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
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
                                        style: GoogleFonts.poppins().copyWith(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: mainColor,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      iconText(MdiIcons.mapMarker, shop.address,
                                          null, null, greyFontStyle, true),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(top: 4),
                                      //   child: Row(
                                      //     children: [RatingStars(shop.rating)],
                                      //   ),
                                      // ),
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
                  shop.status
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
