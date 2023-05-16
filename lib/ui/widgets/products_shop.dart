part of 'widgets.dart';

class ProductsShop extends StatelessWidget {
  final List<Product> products;
  final String emptyText;

  // ProductsShop({Key key, this.products}) : super(key: key);
  ProductsShop({Key key, this.products, this.emptyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (products.length != 0)
            ? SizedBox(
                height: 260,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product = products[index];

                    return ProductItem(
                      product: product,
                      press: () {
                        Navigator.push(
                          _context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              transaction: Transaction(
                                  shop: product.shop,
                                  product: product,
                                  user: (context.read<UserCubit>().state
                                          is UserLoaded)
                                      ? (context.read<UserCubit>().state
                                              as UserLoaded)
                                          .user
                                      : null),
                              onBackButtonPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                        // Get.to(() => ProductDetailsPage(
                        //       transaction: Transaction(
                        //           shop: product.shop,
                        //           product: product,
                        //           user: (context.read<UserCubit>().state
                        //                   is UserLoaded)
                        //               ? (context.read<UserCubit>().state
                        //                       as UserLoaded)
                        //                   .user
                        //               : null),
                        //       onBackButtonPressed: () {
                        //         Get.to(() => MainPage(initialPage: 0));
                        //       },
                        //     ));
                      },
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(width: 16),
                ),
              )
            : CustomAlert(
                icon: MdiIcons.alert,
                type: 'warning',
                title: emptyText),
      ],
    );
  }
}
