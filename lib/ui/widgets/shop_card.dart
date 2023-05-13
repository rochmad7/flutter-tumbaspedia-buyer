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
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: shop.shopPicture ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CardShimmer(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   shop.name ?? '',
                  //   style: GoogleFonts.roboto().copyWith(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.w600,
                  //     color: secondaryColor,
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          shop.name ?? '',
                          style: GoogleFonts.roboto().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: secondaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5),
                      // Icon(
                      //   MdiIcons.face,
                      //   size: 18,
                      //   color: Colors.yellow[700],
                      // ),
                      // SizedBox(width: 5),
                      // Text(
                      //   shop.user.name ?? '',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.grey.withOpacity(0.7),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        MdiIcons.shopping,
                        size: 18,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      SizedBox(width: 5),
                      Text(
                        shop.totalProducts?.toString() ?? '' + ' Produk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(width: 15),
                      Icon(
                        MdiIcons.mapMarker,
                        size: 18,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          shop.address ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!shop.isOpen)
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.red),
                  alignment: Alignment.center,
                  child: Text(
                    'Tutup',
                    style: whiteFontStyle3.copyWith(fontSize: 12),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
