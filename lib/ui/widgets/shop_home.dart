part of 'widgets.dart';

class ShopHome extends StatelessWidget {
  final double defaultMargin;

  const ShopHome({this.defaultMargin = 24});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ShopCubit, ShopState>(
          builder: (_, state) {
            if (state is ShopLoaded) {
              if (state.shops.isNotEmpty) {
                return SizedBox(
                  height: 230,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: defaultMargin),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.shops.length,
                    itemBuilder: (_, index) {
                      final shop = state.shops[index];

                      return Container(
                        margin: EdgeInsets.only(right: defaultMargin),
                        child: ShopItem(
                          shop: shop,
                          defaultMargin: defaultMargin,
                          press: () {
                            Get.to(() => ShopDetailsPage(
                                  transaction: Transaction(
                                      shop: shop,
                                      user: (context.read<UserCubit>().state
                                              is UserLoaded)
                                          ? (context.read<UserCubit>().state
                                                  as UserLoaded)
                                              .user
                                          : null),
                                  onBackButtonPressed: () {
                                    Get.back();
                                  },
                                ));
                          },
                        ),
                      );
                    },
                  ),
                );
              } else {
                return CustomAlert(
                  icon: MdiIcons.alert,
                  type: 'warning',
                  title: 'Toko masih kosong',
                );
              }
            } else if (state is ShopLoadingFailed) {
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
              return ShimmerRow(ratio: 1.38, itemCount: 3);
            }
          },
        ),
      ],
    );
  }
}
