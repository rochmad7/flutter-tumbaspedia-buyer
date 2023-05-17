part of 'pages.dart';

class ProductDetailsPage extends StatefulWidget {
  final Function onBackButtonPressed;
  final Transaction transaction;

  ProductDetailsPage({Key key, this.onBackButtonPressed, this.transaction})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedIndex = 0;
  String image;

  List<Product> products1;
  List<Product> products2;
  List<Photo> photos;

  // List<Rating> listRatings;
  var rating = Rating();
  var listPhotos = <Photo>[];
  var items1 = <Product>[];
  var items2 = <Product>[];
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool isLoadingPhoto = false;
  bool isLoadingRating = false;

  @override
  void initState() {
    super.initState();
    image = widget.transaction.product.images;
    fetchPhotoByProduct();
    fetchDataByShop();
    fetchDataByCategory();
    // if (widget.transaction.product.totalReview > 0) {
    //   fetchRatingsByProduct();
    // }
  }

  void fetchPhotoByProduct() async {
    isLoadingPhoto = true;
    final response = await http.get(
        Uri.parse(baseURLAPI +
            '/product-pictures?product_id=' +
            widget.transaction.product.id.toString()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          var data = jsonDecode(response.body);
          photos =
              (data['data'] as Iterable).map((e) => Photo.fromJson(e)).toList();
          listPhotos.clear();
          listPhotos.addAll(photos);
          Photo initial =
              Photo(id: 0, images: widget.transaction.product.images);
          if (!listPhotos.contains(initial)) {
            listPhotos.insert(0, initial);
          }
          isLoadingPhoto = false;
        });
      }
    }
  }

  // void fetchRatingsByProduct() async {
  //   isLoadingRating = true;
  //   String url = baseURLAPI +
  //       'product/rating?product_id=' +
  //       widget.transaction.product.id.toString() +
  //       '&limit=1';
  //   final response = await http.get(Uri.parse(url), headers: {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json",
  //     "Token": tokenAPI
  //   });
  //   if (response.statusCode == 200) {
  //     if (mounted) {
  //       setState(() {
  //         var data = jsonDecode(response.body);
  //         listRatings = (data['data']['data'] as Iterable)
  //             .map((e) => Rating.fromJson(e))
  //             .toList();
  //         rating = listRatings[0];
  //         isLoadingRating = false;
  //       });
  //     }
  //   }
  // }

  void fetchDataByShop() async {
    isLoading1 = true;
    String url1 = baseURLAPI +
        '/products?shop=' +
        widget.transaction.shop.id.toString() +
        '&excludeIds=' +
        widget.transaction.product.id.toString();
    final response1 = await http.get(Uri.parse(url1), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response1.statusCode == 200) {
      if (mounted) {
        setState(() {
          var data1 = jsonDecode(response1.body);
          products1 = (data1['data'] as Iterable)
              .map((e) => Product.fromJson(e))
              .toList();
          items1.clear();
          items1.addAll(products1);
          isLoading1 = false;
        });
      }
    }
  }

  void fetchDataByCategory() async {
    isLoading2 = true;
    String url2 = baseURLAPI +
        '/products?category=' +
        widget.transaction.product.category.id.toString() +
        '&excludeIds=' +
        widget.transaction.product.id.toString();
    final response2 = await http.get(Uri.parse(url2), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response2.statusCode == 200) {
      if (mounted) {
        setState(() {
          var data2 = jsonDecode(response2.body);
          products2 = (data2['data'] as Iterable)
              .map((e) => Product.fromJson(e))
              .toList();
          items2.clear();
          items2.addAll(products2);
          isLoading2 = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = (context.watch<UserCubit>().state is UserLoaded);
    User user =
        isLogin ? (context.watch<UserCubit>().state as UserLoaded).user : null;
    return Scaffold(
      body: Stack(
        children: [
          Container(color: mainColor),
          SafeArea(child: Container(color: Colors.white)),
          SafeArea(
              child: Stack(children: [
            ListView(
              children: [
                Column(
                  children: [
                    CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      imageUrl: image,
                      placeholder: (context, url) => CardShimmer(
                          isSymmetric: false, height: 300, isCircular: true),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      repeat: ImageRepeat.repeat,
                    ),
                    //// Body
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (listPhotos.length == 1)
                                  ? _productImages(selectedIndex, selectedIndex,
                                      widget.transaction.product.images)
                                  : Container(
                                      width: MediaQuery.of(context).size.width -
                                          64,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: (isLoadingPhoto)
                                            ? ShimmerRow(
                                                height: 30,
                                                itemCount: 5,
                                                isNoMargin: true,
                                                isSymmetric: true)
                                            : ProductImages(
                                                photos: listPhotos,
                                                selectedIndex: selectedIndex,
                                                onTap: (index) {
                                                  setState(() {
                                                    selectedIndex = index;
                                                    image = listPhotos[index]
                                                        .images;
                                                  });
                                                },
                                              ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                140, // 32 + 102
                            child: Text(
                              widget.transaction.product.name,
                              style: blackFontStyle2.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 8),
                                      Image.network(
                                          widget.transaction.product.category
                                              .icon,
                                          width: 18,
                                          height: 18,
                                          color: mainAccentColor,
                                          fit: BoxFit.cover),
                                      SizedBox(width: 4),
                                      Text(
                                        'Kategori ' +
                                            widget.transaction.product.category
                                                .name,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 8),
                                      iconText(
                                          MdiIcons.cart,
                                          "Terjual " +
                                              formatNumber(widget
                                                  .transaction.product.sold),
                                          18,
                                          null,
                                          TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          false),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    getFormatRupiah(
                                        widget.transaction.product.price, true),
                                    style: blackFontStyle2.copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Stok " +
                                        (widget.transaction.product.stock == 0
                                            ? "habis"
                                            : ": " +
                                                widget.transaction.product.stock
                                                    .toString()),
                                    style: widget.transaction.product.stock == 0
                                        ? redFontStyle.copyWith(fontSize: 14)
                                        : blackFontStyle3.copyWith(
                                            fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     SizedBox(
                          //       width: 5,
                          //     ),
                          //     Flexible(
                          //       child: Chip(
                          //         avatar: CircleAvatar(
                          //           backgroundColor: mainAccentColor,
                          //           child: Image.network(
                          //               widget.transaction.product.category.icon,
                          //               width: 18,
                          //               height: 18,
                          //               fit: BoxFit.cover),
                          //         ),
                          //         label: Text(
                          //             widget.transaction.product.category.name,
                          //             overflow: TextOverflow.fade,
                          //             style:
                          //                 blackFontStyle3.copyWith(fontSize: 13)),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 15),
                          Text("Deskripsi : ",
                              style: titleListStyle.copyWith(fontSize: 16)),
                          SizedBox(height: 10),
                          Text(
                            widget.transaction.product.description,
                            style: blackFontStyle.copyWith(fontSize: 15),
                          ),
                          BlocBuilder<UserCubit, UserState>(
                              builder: (_, state) {
                            if (state is UserLoaded) {
                              if (state.user.id ==
                                  widget.transaction.shop.user.id) {
                                return SizedBox();
                              } else {
                                Transaction transaction = widget.transaction
                                    .copyWith(user: state.user);
                                User user = state.user;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ButtonFlexible(
                                      marginTop: 15,
                                      icon: MdiIcons.cart,
                                      press: () =>
                                          (widget.transaction.product.stock ==
                                                  0)
                                              ? snackBar(
                                                  "Maaf, stok produk kosong",
                                                  "Silahkan hubungi penjual",
                                                  'warning')
                                              : (!isShopOpen(
                                                      DateTime.now(),
                                                      widget.transaction.product
                                                          .shop.openedAt,
                                                      widget.transaction.product
                                                          .shop.closedAt))
                                                  ? snackBar(
                                                      "Maaf, toko sedang tutup",
                                                      "Silahkan hubungi penjual",
                                                      'warning')
                                                  : displayBottomSheet(
                                                      context,
                                                      ModalOrder(
                                                        transaction,
                                                        user,
                                                      ),
                                                      0.32,
                                                      true),
                                      title: "Beli Sekarang",
                                      color: mainAccentColor,
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return Column(
                                children: [
                                  SizedBox(height: 15),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ButtonFlexible(
                                          icon: MdiIcons.login,
                                          press: () {
                                            Get.to(() =>
                                                SignInPage(isRedirect: true));
                                          },
                                          title: "Masuk akun untuk memesan",
                                          color: mainColor,
                                        ),
                                      ]),
                                ],
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                    UserInfo(
                        shopuser: widget.transaction.shop.user,
                        pressContact: () async {
                          String name = isLogin ? user.name : '';
                          await launch("https://wa.me/62" +
                              widget.transaction.shop.user.phoneNumber
                                  .allAfter("0") +
                              "?text=[Pesan dari aplikasi Tumbaspedia] Halo Saya " +
                              name +
                              " ingin bertanya-tanya kepada penjual toko " +
                              widget.transaction.shop.name +
                              " mengenai produk Anda yaitu " +
                              widget.transaction.product.name);
                        }),
                    InkWell(
                      onTap: () async {
                        await Get.to(
                          () => ShopDetailsPage(
                            transaction: Transaction(
                                shop: widget.transaction.product.shop,
                                user: (context.read<UserCubit>().state
                                        is UserLoaded)
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
                      child: ShopInfo(
                        shop: widget.transaction.shop,
                      ),
                    ),

                    getProduct(
                        "Produk Lain Toko" + " " + widget.transaction.shop.name,
                        () {
                      Get.to(() => AllProductsPage(
                          shop: widget.transaction.product.shop));
                    }, isLoading1, items1),

                    getProduct(
                        "Produk Lain Kategori" +
                            " " +
                            widget.transaction.product.category.name, () {
                      Get.to(() => AllProductsPage(
                          category: widget.transaction.product.category));
                    }, isLoading2, items2)
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child:
                  //// Back Button
                  IconDetailsPage(press: widget.onBackButtonPressed),
            ),
          ]))
        ],
      ),
    );
  }

  Container getProduct(
      String title, Function press, bool isLoading, List<Product> products) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            // child: Divider(
            //   height: 30,
            //   thickness: 2,
            //   indent: 0,
            //   endIndent: 0,
            //   color: Colors.orange,
            // ),
          ),
          SizedBox(height: 20),
          SectionTitle(
            all: true,
            title: title,
            isColor: true,
            sizeTitle: 18,
            defaultMargin: 15,
          ),
          SizedBox(height: 20),
          isLoading
              ? ShimmerRow()
              : ProductsShop(
                  products: products,
                  emptyText: 'Tidak ada produk lain di kategori ini',
                ),
          SizedBox(height: 20),
          SectionBottom(
            all: true,
            press: press,
            isColor: true,
            title: title,
            defaultMargin: 15,
          ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ModalOrder extends StatefulWidget {
  final Transaction transaction;
  final User user;

  ModalOrder(this.transaction, this.user);

  @override
  _ModalOrderState createState() => _ModalOrderState();
}

class _ModalOrderState extends State<ModalOrder> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    Transaction transaction = widget.transaction.copyWith(
        quantity: quantity, total: quantity * widget.transaction.product.price);
    Product product = widget.transaction.product;
    return Column(children: [
      productBottomSheet(
          context,
          widget.transaction.product.images,
          widget.transaction.product.name,
          getFormatRupiah((widget.transaction.product.price), true),
          quantity.toString() + ' produk'),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stok : " + widget.transaction.product.stock.toString(),
                style: blackFontStyle3,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  ButtonQuantity(
                      image: 'assets/icons/btn_min.png',
                      press: () {
                        setState(() {
                          quantity = max(1, quantity - 1);
                        });
                      }),
                  SizedBox(
                    width: 50,
                    child: Text(
                      quantity.toString(),
                      textAlign: TextAlign.center,
                      style: blackFontStyle2,
                    ),
                  ),
                  ButtonQuantity(
                      image: 'assets/icons/btn_add.png',
                      press: () {
                        setState(() {
                          quantity = (widget.transaction.product.stock == 0)
                              ? 1
                              : min(widget.transaction.product.stock,
                                  quantity + 1);
                          if (quantity >= widget.transaction.product.stock) {
                            Get.snackbar(
                              "",
                              "",
                              backgroundColor: "D9435E".toColor(),
                              icon: Icon(
                                MdiIcons.closeCircleOutline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                "Stok tidak mencukupi",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              messageText: Text(
                                "Stok tersisa ${widget.transaction.product.stock.toString()}",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        });
                      }),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Harga', style: titleListStyle.copyWith(fontSize: 13)),
              Text(
                  getFormatRupiah(
                      quantity * widget.transaction.product.price, true),
                  style: blackFontStyle2.copyWith(fontSize: 20))
            ],
          ),
        ],
      ),
      SizedBox(height: 30),
      ButtonFlexible(
        icon: MdiIcons.cart,
        press: () {
          Navigator.pop(context);
          (widget.user.address != null)
              ? Get.to(
                  () => PaymentPage(transaction: transaction, product: product))
              : Get.to(() => CompleteProfilePage(transaction: transaction));
        },
        title: "Lanjutkan",
        color: mainColor,
      ),
    ]);
  }
}

class ProductImages extends StatelessWidget {
  final List<Photo> photos;
  final int selectedIndex;
  final Function(int) onTap;

  ProductImages({this.selectedIndex, this.onTap, this.photos});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(photos.length, (index) {
        return GestureDetector(
          onTap: () {
            if (onTap != null) {
              onTap(index);
            }
          },
          child: Row(
            children: [
              SizedBox(width: index == 0 ? 0 : 5),
              _productImages(selectedIndex, index, photos[index].images),
            ],
          ),
        );
      }),
    );
  }
}

Widget _productImages(int selectedIndex, int index, String imageUrl) {
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) => Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: (index == selectedIndex)
            ? Border.all(color: mainAccentColor, width: 2)
            : null,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) =>
        CardShimmer(isSymmetric: false, height: 35, isCircular: true),
    errorWidget: (context, url, error) => Icon(Icons.error),
    repeat: ImageRepeat.repeat,
  );
}

class ButtonQuantity extends StatelessWidget {
  final Function press;
  final String image;

  ButtonQuantity({this.press, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1),
            image: DecorationImage(image: AssetImage(image))),
      ),
    );
  }
}
