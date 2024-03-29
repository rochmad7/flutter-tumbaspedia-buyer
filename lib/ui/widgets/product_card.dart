part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function press;

  const ProductCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: product.images,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => CardShimmer(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            repeat: ImageRepeat.repeat,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.name,
                          style: GoogleFonts.roboto().copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              MdiIcons.store,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 110,
                              child: Text(
                                product.shop.name,
                                style: greyFontStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getFormatRupiah(product.price, false),
                              style: GoogleFonts.roboto().copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: mainColor,
                              ),
                            ),
                            // product.sold > 0
                            //     ? Container(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            //   decoration: BoxDecoration(
                            //     color: Colors.orange,
                            //     borderRadius: BorderRadius.circular(15),
                            //   ),
                            //   child: Text(
                            //     "Terjual " + formatNumber(product.sold),
                            //     style: whiteFontStyle.copyWith(fontSize: 12),
                            //   ),
                            // )
                            //     : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: product.sold > 0
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Terjual " + formatNumber(product.sold),
                        style: whiteFontStyle.copyWith(fontSize: 13),
                      ),
                    )
                  : SizedBox(),
            ),
          ])),
    );
  }
}
