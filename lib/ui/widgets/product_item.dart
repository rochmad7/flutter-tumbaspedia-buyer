part of 'widgets.dart';

class ProductItem extends StatelessWidget {
  final Function press;
  const ProductItem(
      {Key key,
      this.width = 140,
      this.aspectRetio = 1.02,
      @required this.product,
      this.press})
      : super(key: key);

  final double width, aspectRetio;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: SizedBox(
          width: (width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.02,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
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
                  ),
                  product.sold > 0
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            color: Colors.black87,
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            // decoration: BoxDecoration(shape: BoxShape.rectangle),
                            alignment: Alignment.center,
                            child: Text("Terjual " + formatNumber(product.sold),
                                style: whiteFontStyle.copyWith(fontSize: 11)),
                          ),
                        )
                      : SizedBox()
                ],
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: GoogleFonts.poppins().copyWith(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    MdiIcons.shopping,
                    size: defaultIconSize,
                    color: secondaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 110,
                    child: Text(
                      product.shop.name,
                      style: greyFontStyle,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getFormatRupiah(product.price, false),
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
