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
    String url =
        baseURLAPI + '/products?page=1&shop=' + widget.transaction.shop.id.toString();
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          var data = jsonDecode(response.body);
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
              imageBuilder: (context, imageProvider) =>
                  Container(
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
              placeholder: (context, url) =>
                  CardShimmer(
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
                        padding: EdgeInsets.symmetric(
                            vertical: 26, horizontal: 16),
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
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width -
                                          145, // 32 + 102
                                      child: Text(
                                        widget.transaction.shop.name,
                                        style: blackFontStyle2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        iconText(
                                            MdiIcons.clockOutline,
                                            "Buka " +
                                                widget
                                                    .transaction.shop.openedAt,
                                            15,
                                            Colors.green[900],
                                            null,
                                            false),
                                        SizedBox(width: 6),
                                        iconText(
                                            MdiIcons.clockAlertOutline,
                                            "Tutup " +
                                                widget.transaction.shop
                                                    .closedAt,
                                            15,
                                            Colors.red,
                                            null,
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
                                      color: widget.transaction.shop.isOpen
                                          ? Colors.green
                                          : Colors.red),
                                  alignment: Alignment.center,
                                  child: Text(
                                      widget.transaction.shop.isOpen
                                          ? "Buka"
                                          : "Tutup",
                                      style:
                                      whiteFontStyle3.copyWith(fontSize: 12)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Alamat : ",
                              style: titleListStyle.copyWith(fontSize: 13),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  MdiIcons.mapMarker,
                                  size: defaultIconSize,
                                  color: secondaryColor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.transaction.shop.address,
                                    style: blackFontStyle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            ExpandableText(
                                header: Text('Deskripsi:',
                                    style: titleListStyle.copyWith(
                                        fontSize: 13)),
                                text: widget.transaction.shop.description,
                                maxLines: 4),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  (context
                                      .watch<UserCubit>()
                                      .state is UserLoaded)
                                      ? ((context
                                      .watch<UserCubit>()
                                      .state
                                  as UserLoaded)
                                      .user
                                      .id !=
                                      widget.transaction.shop.user.id)
                                      ? ButtonFlexible(
                                    icon: MdiIcons.whatsapp,
                                    press: () async =>
                                    await launch(
                                        "https://wa.me/62" +
                                            widget.transaction.shop.user
                                                .phoneNumber
                                                .allAfter("0") +
                                            "?text=[Pesan dari aplikasi Doltinuku] Halo Saya " +
                                            (context
                                                .read<UserCubit>()
                                                .state as UserLoaded)
                                                .user
                                                .name +
                                            " ingin bertanya-tanya kepada penjual toko " +
                                            widget.transaction.shop.name),
                                    title: "Kontak Penjual",
                                    color: "#128C7E".toColor(),
                                  )
                                      : SizedBox()
                                      : ButtonFlexible(
                                    icon: MdiIcons.login,
                                    press: () {
                                      Get.to(
                                              () =>
                                              SignInPage(isRedirect: true));
                                    },
                                    title: "Login untuk memesan",
                                    color: mainColor,
                                  )
                                ]),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SectionTitle(
                                  all: true,
                                  isColor: true,
                                  title: "Produk UKM",
                                  press: () {
                                    Get.to(() =>
                                        AllProductsPage(
                                            shop: widget.transaction.shop));
                                  },
                                  defaultMargin: 16,
                                ),
                                SizedBox(height: 10),
                                isLoading
                                    ? ShimmerRow()
                                    : ProductsShop(products: items),
                                SizedBox(height: 30),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
