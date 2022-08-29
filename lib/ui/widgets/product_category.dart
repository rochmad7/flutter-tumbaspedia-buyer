part of 'widgets.dart';

class ProductCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (_, state) {
      if (state is CategoryLoaded) {
        return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: state.categories
                    .map((e) => CategoryProduct(
                          left: (e == state.categories.first)
                              ? defaultMargin
                              : defaultMargin / 2,
                          right:
                              (e == state.categories.last) ? defaultMargin : 0,
                          category: e,
                        ))
                    .toList()));
      } else if (state is CategoryLoadingFailed) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: defaultFontSize),
          child: CustomAlert(
              title: "Maaf! " + state.message,
              icon: MdiIcons.alert,
              type: 'error',
              isDistance: false,
              isCenter: false),
        );
      } else {
        return Column(children: [
          ShimmerRow(ratio: 1, itemCount: 3, isSymmetric: false, height: 60),
          SizedBox(height: 10)
        ]);
      }
    });
  }
}

class CategoryProduct extends StatelessWidget {
  final Category category;
  final double left;
  final double right;

  CategoryProduct({this.right, this.left, this.category});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: left, right: right, top: 24),
      height: 110,
      child: CategoryItem(
        icon: category.icon,
        text: category.name,
        press: () {
          Get.to(() => AllProductsPage(category: category));
        },
      ),
    );
  }
}
