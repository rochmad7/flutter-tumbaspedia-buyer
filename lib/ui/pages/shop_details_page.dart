part of 'pages.dart';

class ShopDetailsPage extends StatefulWidget {
  final Function onBackButtonPressed;
  final Transaction transaction;
  final Shop shop;

  ShopDetailsPage({this.onBackButtonPressed, this.transaction, this.shop});

  @override
  _ShopDetailsPageState createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  List<Product> products;
  var items = <Product>[];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDataByShop();
  }

  void fetchDataByShop() async {
    isLoading = true;
    String url = baseURLAPI +
        '/products?page=1&shop=' +
        widget.transaction.shop.id.toString();
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    var data = jsonDecode(response.body);

    if (data['errors'] == null) {
      if (mounted) {
        setState(() {
          products = (data['data'] as Iterable)
              .map((e) => Product.fromJson(e))
              .toList();
          items.clear();
          items.addAll(products);
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: mainColor,
          ),
          SafeArea(
              child: Container(
            color: Colors.white,
          )),
          SafeArea(
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              placeholder: (context, url) => CardShimmer(
                  isSymmetric: false, height: 300, isCircular: true),
              imageUrl: widget.transaction.shop.shopPicture,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SafeArea(
              child: ListView(
            children: [
              Column(
                children: [
                  //// Back Button
                  IconDetailsPage(press: widget.onBackButtonPressed),
                  //// Body
                  Container(
                    margin: EdgeInsets.only(top: 180),
                    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      2 * defaultMargin -
                                      78,
                                  child: Text(
                                    widget.transaction.shop.name,
                                    style: blackFontStyle2.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    iconText(
                                        MdiIcons.clockOutline,
                                        "Buka " +
                                            widget.transaction.shop.openedAt,
                                        18,
                                        Colors.green,
                                        TextStyle(
                                            color: Colors.green,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        false),
                                    SizedBox(width: 6),
                                    iconText(
                                        MdiIcons.clockAlertOutline,
                                        "Tutup " +
                                            widget.transaction.shop.closedAt,
                                        18,
                                        Colors.red,
                                        TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        false),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: DateTime.now().hour >=
                                              int.parse(widget
                                                  .transaction.shop.openedAt
                                                  .split(":")[0]) &&
                                          DateTime.now().hour <
                                              int.parse(widget
                                                  .transaction.shop.closedAt
                                                  .split(":")[0])
                                      ? Colors.green
                                      : Colors.red),
                              alignment: Alignment.center,
                              child: Text(
                              (isShopOpen(DateTime.now(), widget.transaction.shop.openedAt, widget.transaction.shop.closedAt))
                                      ? "Buka"
                                      : "Tutup",
                                  // widget.transaction.shop.isOpen
                                  //     ? "Buka"
                                  //     : "Tutup",
                                  style:
                                      whiteFontStyle3.copyWith(fontSize: 14)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Alamat : ",
                          style: titleListStyle.copyWith(fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              MdiIcons.mapMarker,
                              size: 20,
                              color: secondaryColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                widget.transaction.shop.address,
                                style: blackFontStyle.copyWith(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text("Deskripsi : ",
                            style: titleListStyle.copyWith(fontSize: 16)),
                        SizedBox(height: 10),
                        Text(
                          widget.transaction.shop.description,
                          style: blackFontStyle.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        UserInfo(shopuser: widget.transaction.shop.user),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (context.watch<UserCubit>().state is UserLoaded)
                                  ? ((context.watch<UserCubit>().state
                                                  as UserLoaded)
                                              .user
                                              .id !=
                                          widget.transaction.shop.user.id)
                                      ? ButtonFlexible(
                                          icon: MdiIcons.whatsapp,
                                          press: () async => await launch(
                                              "https://wa.me/62" +
                                                  widget.transaction.shop.user
                                                      .phoneNumber
                                                      .allAfter("0") +
                                                  "?text=[Pesan dari aplikasi Tumbaspedia] Halo Saya " +
                                                  (context
                                                          .read<UserCubit>()
                                                          .state as UserLoaded)
                                                      .user
                                                      .name +
                                                  " ingin bertanya-tanya kepada penjual toko " +
                                                  widget.transaction.shop.name),
                                          title: "Hubungi Penjual",
                                          color: "#128C7E".toColor(),
                                        )
                                      : SizedBox()
                                  : ButtonFlexible(
                                      icon: MdiIcons.login,
                                      press: () {
                                        Get.to(
                                            () => SignInPage(isRedirect: true));
                                      },
                                      title: "Masuk akun untuk memesan",
                                      color: mainAccentColor,
                                    )
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
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
                  Container(
                    height: 400,
                    margin: EdgeInsets.symmetric(vertical: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        SectionTitle(title: "Produk Toko"),
                        SizedBox(height: 10),
                        isLoading
                            ? ShimmerRow()
                            : ProductsShop(products: items, emptyText: 'Tidak ada produk di toko ini',),
                        SizedBox(height: 20),
                        SectionBottom(
                          all: true,
                          isColor: true,
                          title: "Produk UMKM",
                          press: () {
                            Get.to(() =>
                                AllProductsPage(shop: widget.transaction.shop));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
