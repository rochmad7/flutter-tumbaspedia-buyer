part of 'widgets.dart';

class ProductListItem extends StatelessWidget {
  final double itemWidth;
  final Function press;
  const ProductListItem(
      {Key key,
      this.width = 140,
      this.itemWidth,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: 12),
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  imageUrl: product.images,
                  placeholder: (context, url) => CardShimmer(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              SizedBox(
                width: (itemWidth) - 182, // (60 + 12 + 110)
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: blackFontStyle2,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    iconText(
                        MdiIcons.cart,
                        "Terjual " + product.sold.toString(),
                        null,
                        null,
                        greyFontStyle13,false),
                  ],
                ),
              ),
            ],
          ),
          Text(
            getFormatRupiah(product.price, true),
            style: GoogleFonts.roboto().copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: mainColor,
            ),
          )
        ],
      ),
    );
  }
}
