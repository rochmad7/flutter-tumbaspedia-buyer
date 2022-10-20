part of 'pages.dart';

class HomePage extends StatelessWidget {
  final TextEditingController keywordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context
            .read<ProductCubit>()
            .getProducts(null, null, 10, null, null);
        await context.read<ShopCubit>().getShops(null, null, 10, null);
        await context.read<CategoryCubit>().getCategories(null);
        await context.read<SliderCubit>().getSliders(0, 8);
        if (context.read<UserCubit>().state is UserLoaded) {
          return await context.read<TransactionCubit>().getTransactions(null);
        }
      },
      child: ListView(
        children: [
          Column(
            children: [
              // HEADER
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                // color: Colors.white,
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo/home_logo.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: Row(
                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       // crossAxisAlignment: CrossAxisAlignment.start,
                //       // mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         // Text(
                //         //   "Tumbaspedia",
                //         //   style: blackFontStyle1,
                //         // ),
                //         // Text(
                //         //   "Marketplace produk UMKM Rowosari",
                //         //   style: greyFontStyle.copyWith(
                //         //     fontWeight: FontWeight.w300,
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                color: Colors.white,
                child: SearchField(
                  press: () {
                    Get.to(() => AllProductsPage(
                          focusNode: focusNode,
                        ));
                  },
                  title: "Cari Produk UMKM",
                  searchController: keywordController,
                ),
              ),
              // CustomSearchWidget(),
              // BannerHome(),
              ProductCategory(),
              const Divider(
                height: 30,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.orange,
              ),
              Column(
                children: [
                  SectionTitle(title: "Toko"),
                  SizedBox(height: 10),
                  ShopHome(),
                  SectionBottom(
                    all: true,
                    title: "Lihat Semua",
                    press: () {
                      Get.to(() => AllShopsPage());
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              const Divider(
                height: 30,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.orange,
              ),
              Column(
                children: [
                  SectionTitle(
                    all: true,
                    title: "Produk",
                  ),
                  SizedBox(height: 10),
                  ProductHome(),
                  SizedBox(height: 20.0),
                  SectionBottom(
                      all: true,
                      title: "Produk",
                      press: () {
                        Get.to(() => AllProductsPage());
                      }),
                ],
              ),
              SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}
