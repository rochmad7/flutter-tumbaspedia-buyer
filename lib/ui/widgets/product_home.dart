part of 'widgets.dart';

class ProductHome extends StatelessWidget {
  ProductHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProductCubit, ProductState>(
          builder: (_, state) {
            if (state is ProductLoaded) {
              List<Product> products = state.products;

              if (products.length != 0) {
                return SingleChildScrollView(
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
                                  // Navigator.of(context).pop();
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
                );
              } else {
                return CustomAlert(
                    icon: MdiIcons.alert,
                    type: 'warning',
                    title: 'Produk masih kosong');
              }
            } else if (state is ProductLoadingFailed) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: CustomAlert(
                    title: "Maaf! " + state.message,
                    icon: MdiIcons.alert,
                    type: 'error',
                    isDistance: false,
                    isCenter: false),
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
