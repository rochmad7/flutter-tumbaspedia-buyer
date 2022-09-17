part of 'pages.dart';

class TransactionDetailsPage extends StatefulWidget {
  final Transaction transaction;
  final Function press;

  TransactionDetailsPage({this.transaction, this.press});

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  bool isLoading = false;
  bool isLoadingRating = false;
  Rating rating;
  bool isConfirmed = false;

  @override
  void initState() {
    super.initState();
    // fetchRatingsByTransaction();
  }

  // void fetchRatingsByTransaction() async {
  //   isLoadingRating = true;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String url = baseURLAPI + 'transaction/checkrating';
  //   final response = await http.post(Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //         "Token": tokenAPI,
  //         "Authorization": "Bearer ${prefs.getString('token')}"
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'transaction_id': widget.transaction.id,
  //       }));
  //   if (response.statusCode == 200) {
  //     if (mounted) {
  //       setState(() {
  //         var data = jsonDecode(response.body);
  //         rating = Rating.fromJson(data['data']['rating']);
  //         isLoadingRating = false;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       isLoadingRating = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // var type =
    //     (widget.transaction.product.category.id == 3) ? "jasa" : "barang";
    String url = "https://wa.me/62" +
        widget.transaction.shop.user.phoneNumber.allAfter("0");
    String message = url +
        "?text=[Pesan dari aplikasi Tumbaspedia] Halo Saya " +
        widget.transaction.user.name +
        " ingin memesan " +
        widget.transaction.product.name +
        " di toko " +
        widget.transaction.shop.name +
        " dengan jumlah " +
        widget.transaction.quantity.toString() +
        " dan total harga " +
        getFormatRupiah(widget.transaction.total, true);
    return GeneralPage(
      title: 'Pesanan',
      subtitle: 'Detail pesanan Anda',
      onBackButtonPressed: widget.press,
      backColor: 'FAFAFC'.toColor(),
      child: Column(
        children: [
          //// Bagian atas
          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan [ID: ' + widget.transaction.id.toString() + "]",
                  style: titleListStyle,
                ),
                SizedBox(height: 12),
                InkWell(
                  onTap: () async {
                    // Navigator.of(context).pop();
                    await Get.to(
                      () => ProductDetailsPage(
                        transaction: widget.transaction.copyWith(
                            shop: widget.transaction.shop,
                            product: widget.transaction.product),
                        onBackButtonPressed: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                  child: Row(
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
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                            imageUrl: widget.transaction.product.images,
                            fit: BoxFit.cover,
                            // placeholder: (context, url) =>
                            //     CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            repeat: ImageRepeat.repeat,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 198,
                                // 2 * defaultMargin (jarak border) +
                                // 60 (lebar picture) +
                                // 12 (jarak picture ke title)+
                                // 78 (lebar jumlah items),
                                child: Text(
                                  widget.transaction.product.name,
                                  style: blackFontStyle2,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text(
                                getFormatRupiah(
                                    (widget.transaction.product.price).round(),
                                    true),
                                style: textListStyle.copyWith(fontSize: 13),
                              )
                            ],
                          )
                        ],
                      ),
                      Text(
                        '${widget.transaction.quantity} item(s)',
                        style: textListStyle.copyWith(fontSize: 13),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 5),
                  child: Text(
                    'Detail Toko',
                    style: titleListStyle,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    // Navigator.of(context).pop();
                    await Get.to(
                      () => ShopDetailsPage(
                        transaction: Transaction(
                            shop: widget.transaction.shop,
                            user:
                                (context.read<UserCubit>().state is UserLoaded)
                                    ? (context.read<UserCubit>().state
                                            as UserLoaded)
                                        .user
                                    : null),
                        onBackButtonPressed: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2 -
                              defaultMargin -
                              5,
                          child: Text(
                            "Nama Toko",
                            style: textListStyle.copyWith(fontSize: 14),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2 -
                              defaultMargin -
                              5,
                          child: Text(
                            widget.transaction.shop.name,
                            style: blackFontStyle3,
                            textAlign: TextAlign.right,
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 6),
                TitleList(title: "Detail Pesanan"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          widget.transaction.product.name,
                          style: textListStyle.copyWith(fontSize: 14),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          getFormatRupiah(
                              widget.transaction.product.price, true),
                          style: blackFontStyle3,
                          textAlign: TextAlign.right,
                        ))
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          'Total',
                          style: textListStyle.copyWith(fontSize: 14),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            defaultMargin -
                            5,
                        child: Text(
                          getFormatRupiah(
                              (widget.transaction.total).round(), true),
                          style: titleListStyle,
                          textAlign: TextAlign.right,
                        ))
                  ],
                ),
                TitleList(title: "Status Pesanan"),
                ItemList(
                    title: "Tanggal",
                    subtitle: convertDate(widget.transaction.dateTime, true)),
                SizedBox(height: 6),
                ItemList(
                    title: "Waktu",
                    subtitle: convertTime(widget.transaction.dateTime)),
                SizedBox(
                  height: 6,
                ),
                ItemList(
                  title: "Status",
                  customSubtitle: (widget.transaction.status ==
                          TransactionStatus.cancelled)
                      ? Text(
                          'Dibatalkan',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(color: 'D9435E'.toColor()),
                        )
                      : (widget.transaction.status == TransactionStatus.pending)
                          ? Text(
                              'Pesanan Baru',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                  color: 'D9435E'.toColor()),
                            )
                          : (widget.transaction.status ==
                                  TransactionStatus.on_delivery)
                              ? Text(
                                  'Diantar',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      color: "#128C7E".toColor()),
                                )
                              : Text(
                                  'Pesanan Selesai',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      color: "#128C7E".toColor()),
                                ),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
          //// Bagian bawah
          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dipesan oleh',
                  style: titleListStyle,
                ),
                SizedBox(height: 8),
                ItemList(title: "Nama", subtitle: widget.transaction.user.name),
                SizedBox(height: 6),
                ItemList(
                    title: "No HP",
                    subtitle: widget.transaction.user.phoneNumber),
                SizedBox(height: 6),
                ItemList(
                    title: "Alamat", subtitle: widget.transaction.user.address),
                SizedBox(height: 6),
              ],
            ),
          ),
          ButtonIconDefault(
              title: "Hubungi Penjual",
              color: "#128C7E".toColor(),
              press: () async => await launch(
                  (widget.transaction.status == TransactionStatus.pending)
                      ? message
                      : url),
              icon: MdiIcons.whatsapp),
          SizedBox(height: 8),
          (widget.transaction.status == TransactionStatus.on_delivery &&
                  !isConfirmed)
              ? ButtonIconDefault(
                  title: "Konfirmasi Terima Pesanan",
                  color: mainColor,
                  press: () {
                    SweetAlert.show(context,
                        subtitle:
                            "Apakah Anda yakin telah\nmenerima pesanan ini?",
                        style: SweetAlertStyle.confirm,
                        showCancelButton: true,
                        onPress: confirm);
                  },
                  icon: MdiIcons.check)
              : SizedBox(),
          // (widget.transaction.status == TransactionStatus.pending)
          //     ?
          //     //// Cancel Button
          //     (isLoading)
          //         ? Center(
          //             child: loadingIndicator,
          //           )
          //         : Container(
          //             margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          //             height: 50,
          //             width: double.infinity,
          //             child: RaisedButton(
          //               onPressed: () {},
          //               elevation: 0,
          //               color: "D9435E".toColor(),
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(8)),
          //               child: Text(
          //                 "Batalkan Pesanan",
          //                 style: whiteFontStyle3.copyWith(
          //                     fontWeight: FontWeight.w500, fontSize: 16),
          //               ),
          //             ),
          //           )
          //     : SizedBox(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  bool confirm(bool isConfirm) {
    if (isConfirm) {
      SweetAlert.show(context,
          subtitle: "Sedang memproses...", style: SweetAlertStyle.loading);
      new Future.delayed(new Duration(seconds: 0), () async {
        await context
            .read<TransactionCubit>()
            .confirmDelivered(widget.transaction);
        TransactionState state = context.read<TransactionCubit>().state;
        if (state is TransactionConfirmed) {
          SweetAlert.show(context,
              subtitle:
                  "Terimakasih, konfirmasi terima\npesanan berhasil dikirim",
              style: SweetAlertStyle.success);
          snackBar(
              "Success",
              "Terimakasih, konfirmasi terima pesanan Anda berhasil dikirim",
              'success');
          context.read<TransactionCubit>().getTransactions(null);
          new Future.delayed(new Duration(seconds: 3), () {
            Get.off(() => MainPage(initialPage: 3));
            new Future.delayed(new Duration(seconds: 2), () {
              displayBottomSheet(
                  context,
                  SubmitRatingReview(
                      transaction: widget.transaction,
                      product: widget.transaction.product),
                  0.6,
                  false);
            });
          });
          return false;
        } else {
          SweetAlert.show(context,
              subtitle: (state as TransactionConfirmFailed).message,
              style: SweetAlertStyle.error);
          context.read<TransactionCubit>().getTransactions(null);
          return false;
        }
      });
    } else {
      SweetAlert.show(context,
          subtitle: "Konfirmasi terima pesanan\ntelah berhasil dibatalkan",
          style: SweetAlertStyle.error);
    }
    return false;
  }
}

class SubmitRatingReview extends StatefulWidget {
  final Rating initialRating;
  final Transaction transaction;
  final Product product;

  SubmitRatingReview({this.initialRating, this.transaction, this.product});

  @override
  _SubmitRatingReviewState createState() => _SubmitRatingReviewState();
}

class _SubmitRatingReviewState extends State<SubmitRatingReview> {
  TextEditingController reviewController = TextEditingController();
  double _rating = 3;
  double _initialRating = 0.0;
  bool noUpdate = true;
  bool isLoading = false;
  Map<String, dynamic> error;
  bool isSuccessSubmit = false;
  String messageRating = 'Terimakasih telah memberikan penilaian';

  IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    if (widget.initialRating != null) {
      reviewController.text = widget.initialRating.review;
      _initialRating = widget.initialRating.rating;
    }
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    bool isInitialRating = widget.initialRating != null ? true : false;
    if (isSuccessSubmit)
      return CustomIllustration(
          title: 'Berhasil!',
          sizeTitle: 24,
          subtitle: messageRating,
          picturePath: success);
    else
      return SingleChildScrollView(
        child: Column(
          children: [
            Text(
                isInitialRating
                    ? "Penilaian Anda sebelumnya"
                    : "Yuk, bantu kami menilai produk ini",
                style: blackFontStyle2),
            SizedBox(height: 5),
            productBottomSheet(
                context,
                widget.transaction.product.images,
                widget.transaction.product.name,
                null,
                getFormatRupiah((widget.transaction.product.price), true)),
            _ratingBar(),
            SizedBox(height: 5),
            TextDanger(error: error, param: "rating"),
            SizedBox(height: 5),
            TextFieldDefault(
                isPrefixIcon: false,
                isMaxLines: true,
                maxLines: 3,
                maxLength: 350,
                controller: reviewController,
                hintText: "Penilaian Anda (Opsional)"),
            TextDanger(error: error, param: "review"),
            SizedBox(height: 10),
            isInitialRating
                ? ButtonDefault(
                    title: "Simpan",
                    isLoading: isLoading,
                    press: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await context.read<RatingCubit>().update(
                          widget.initialRating.id,
                          _rating,
                          reviewController.text);
                      RatingState state = context.read<RatingCubit>().state;

                      if (state is RatingEdited) {
                        context.read<TransactionCubit>().getTransactions(null);
                        context
                            .read<ProductCubit>()
                            .getProducts(null, null, 10, null, null);
                        context
                            .read<ShopCubit>()
                            .getShops(null, null, 10, null);
                        context.read<CategoryCubit>().getCategories(null);
                        setState(() {
                          messageRating = 'Penilaian Anda berhasil diupdate';
                          isLoading = false;
                          isSuccessSubmit = true;
                        });
                        new Future.delayed(new Duration(seconds: 1), () {
                          Get.off(() => MainPage(initialPage: 3));
                        });
                      } else {
                        snackBar("Update penilaian gagal",
                            (state as RatingEditedFailed).message, 'error');

                        setState(() {
                          error = (state as RatingEditedFailed).error != null
                              ? (state as RatingEditedFailed).error
                              : null;
                          isLoading = false;
                        });
                      }
                    })
                : ButtonDefault(
                    title: "Kirim",
                    isLoading: isLoading,
                    press: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await context.read<RatingCubit>().submit(
                          widget.transaction,
                          widget.product,
                          _rating,
                          reviewController.text,
                          noUpdate);
                      RatingState state = context.read<RatingCubit>().state;

                      if (state is RatingAdded) {
                        context.read<TransactionCubit>().getTransactions(null);
                        context
                            .read<ProductCubit>()
                            .getProducts(null, null, 10, null, null);
                        context
                            .read<ShopCubit>()
                            .getShops(null, null, 10, null);
                        context.read<CategoryCubit>().getCategories(null);
                        setState(() {
                          isLoading = false;
                          isSuccessSubmit = true;
                        });
                      } else {
                        snackBar("Penilaian gagal",
                            (state as RatingAddedFailed).message, 'error');

                        setState(() {
                          error = (state as RatingAddedFailed).error != null
                              ? (state as RatingAddedFailed).error
                              : null;
                          isLoading = false;
                        });
                      }
                    })
          ],
        ),
      );
  }

  Widget _ratingBar() {
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          noUpdate = false;
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}

class TitleList extends StatelessWidget {
  final String title;

  TitleList({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: titleListStyle,
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget customSubtitle;

  ItemList({this.title, this.subtitle, this.customSubtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 80,
              child: Text(
                title,
                style: textListStyle.copyWith(fontSize: 14),
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width - 2 * defaultMargin - 80,
              child: customSubtitle != null
                  ? customSubtitle
                  : Text(
                      subtitle,
                      style: blackFontStyle3,
                      textAlign: TextAlign.right,
                    ))
        ]);
  }
}
