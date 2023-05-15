part of 'widgets.dart';
class ProductHome extends StatelessWidget {
  const ProductHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        BlocBuilder<ProductCubit, ProductState>(
          builder: (_, state) {
            if (state is ProductLoaded) {
              final products = state.products;

              if (products.isNotEmpty) {
                return SizedBox(
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
                          Get.to(() => ProductDetailsPage(
                            transaction: Transaction(
                                shop: product.shop,
                                product: product,
                                user: (context.read<UserCubit>().state is UserLoaded)
                                    ? (context.read<UserCubit>().state as UserLoaded).user
                                    : null),
                            onBackButtonPressed: () {
                              Get.to(() => MainPage(initialPage: 0));
                            },
                          ));
                        },
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 16),
                  ),
                );
              } else {
                return CustomAlert(
                  icon: MdiIcons.alert,
                  type: 'warning',
                  title: 'Produk masih kosong',
                );
              }
            } else if (state is ProductLoadingFailed) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: CustomAlert(
                  title: "Maaf! " + state.message,
                  icon: MdiIcons.alert,
                  type: 'error',
                  isDistance: false,
                  isCenter: false,
                ),
              );
            } else {
              return ShimmerRow();
            }
          },
        ),
      ],
    );
  }
}
