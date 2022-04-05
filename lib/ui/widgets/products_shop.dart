part of 'widgets.dart';

class ProductsShop extends StatelessWidget {
  final List<Product> products;

  ProductsShop({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (products.length != 0)
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: products
                          .take(10)
                          .map(
                            (e) => ProductItem(
                              product: e,
                              press: () {
                                Navigator.of(_context).pop();
                                Get.to(
                                  () => ProductDetailsPage(
                                    transaction: Transaction(
                                        shop: e.shop,
                                        product: e,
                                        user: (context.read<UserCubit>().state
                                                is UserLoaded)
                                            ? (context.read<UserCubit>().state
                                                    as UserLoaded)
                                                .user
                                            : null),
                                    onBackButtonPressed: () {
                                      Get.to(() => MainPage(initialPage: 0));
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              )
            : CustomAlert(
                icon: MdiIcons.alert,
                type: 'warning',
                title: 'Produk masih kosong'),
      ],
    );
  }
}
