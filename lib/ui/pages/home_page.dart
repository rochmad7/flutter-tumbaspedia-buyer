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
                color: Colors.white,
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Doltinuku",
                          style: blackFontStyle1,
                        ),
                        Text(
                          "Marketplace produk UKM Gerai Kopimi",
                          style: greyFontStyle.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                  title: "Cari Produk UKM",
                  searchController: keywordController,
                ),
              ),
              // CustomSearchWidget(),
              BannerHome(),
              ProductCategory(),
              Column(
                children: [
                  SectionTitle(
                      all: true,
                      title: "Toko",
                      press: () {
                        Get.to(() => AllShopsPage());
                      }),
                  SizedBox(height: 10),
                  ShopHome(),
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                children: [
                  SectionTitle(
                      all: true,
                      title: "Produk",
                      press: () {
                        Get.to(() => AllProductsPage());
                      }),
                  SizedBox(height: 10),
                  ProductHome(),
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
