part of 'widgets.dart';

class OrderListItem extends StatelessWidget {
  final Transaction transaction;
  final double itemWidth;
  final Function press;
  final bool isDate;

  OrderListItem(
      {@required this.transaction,
      this.isDate = true,
      @required this.itemWidth,
      this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
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
              imageUrl: transaction.product.images,
              placeholder: (context, url) => CardShimmer(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              repeat: ImageRepeat.repeat,
            ),
          ),
          SizedBox(
            width: itemWidth - 182, // (60 + 12 + 110)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.product.name,
                  style: blackFontStyle2.copyWith(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${transaction.quantity} item(s) • " +
                      getFormatRupiah(transaction.product.price, true),
                  style: greyFontStyle.copyWith(fontSize: 13),
                )
              ],
            ),
          ),
          isDate
              ? SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        convertDate(transaction.dateTime, false),
                        style: greyFontStyle.copyWith(fontSize: 12),
                      ),
                      Text(
                        convertTime(transaction.dateTime),
                        style: greyFontStyle.copyWith(fontSize: 12),
                      ),
                      (transaction.status == TransactionStatus.cancelled)
                          ? Text(
                              'Dibatalkan',
                              style: GoogleFonts.poppins(
                                  color: 'D9435E'.toColor(), fontSize: 10),
                            )
                          : (transaction.status == TransactionStatus.pending)
                              ? Text(
                                  'Pesanan Baru',
                                  style: GoogleFonts.poppins(
                                      color: 'D9435E'.toColor(), fontSize: 10),
                                )
                              : (transaction.status ==
                                      TransactionStatus.on_delivery)
                                  ? Text(
                                      'Diantar',
                                      style: GoogleFonts.poppins(
                                          color: '1ABC9C'.toColor(),
                                          fontSize: 10),
                                    )
                                  : Text(
                                      'Selesai',
                                      style: GoogleFonts.poppins(
                                          color: '1ABC9C'.toColor(),
                                          fontSize: 10),
                                    )
                    ],
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
