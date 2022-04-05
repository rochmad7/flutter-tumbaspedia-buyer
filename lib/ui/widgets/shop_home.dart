part of 'widgets.dart';

class ShopHome extends StatelessWidget {
  final double defaultMargin;

  ShopHome({this.defaultMargin = 24});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ShopCubit, ShopState>(
          builder: (_, state) {
            if (state is ShopLoaded) {
              if (state.shops.length != 0) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: state.shops
                            .take(10)
                            .map(
                              (e) => ShopItem(
                                shop: e,
                                defaultMargin: defaultMargin,
                                press: () {
                                  Get.to(
                                    () => ShopDetailsPage(
                                      transaction: Transaction(
                                          shop: e,
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
                              ),
                            )
                            .toList(),
                      ),
                      // here by default width and height is 0

                      SizedBox(width: 20),
                    ],
                  ),
                );
              } else {
                return CustomAlert(
                    icon: MdiIcons.alert,
                    type: 'warning',
                    title: 'Toko masih kosong');
              }
            } else if (state is ShopLoadingFailed) {
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
              return ShimmerRow(ratio: 1.38, itemCount: 3);
            }
          },
        ),
      ],
    );
  }
}
