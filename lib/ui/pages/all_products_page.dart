part of 'pages.dart';

class AllProductsPage extends StatefulWidget {
  final Category category;
  final FocusNode focusNode;
  final Shop shop;

  AllProductsPage({this.category, this.shop, this.focusNode});

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  static const _pageSize = 8;
  final TextEditingController keywordController = TextEditingController();
  String query;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var category;
      var shop;
      category = widget.category != null ? widget.category.id : null;
      shop = widget.shop != null ? widget.shop.id : null;
      final newItems = await ProductServices.getProducts(
          query, pageKey, _pageSize, category, shop, null);

      final isLastPage = newItems.value.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.value);
      } else {
        if (pageKey == 0) {
          _pagingController.appendPage(newItems.value, pageKey + 2);
        } else {
          _pagingController.appendPage(newItems.value, pageKey + 1);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Column(
        children: [
          SizedBox(height: 8),
          TitlePage(
            title: "Produk UMKM",
            subtitle: (widget.category != null)
                ? "Kategori " + widget.category.name
                : "Semua Produk" + ((widget.shop != null)
                    ? " dari " + widget.shop.name
                    : ""),
            onBackButtonPressed: () {
              Get.back();
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: SearchField(
              onChanged: _updateSearchTerm,
              searchController: keywordController,
              title: "Cari Produk",
              focusNode: widget.focusNode,
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
              child: PagedListView<int, Product>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Product>(
                  itemBuilder: (context, item, index) => Container(
                    margin: EdgeInsets.only(
                        bottom: 12, left: defaultMargin, right: defaultMargin),
                    child: ProductListItem(
                      product: item,
                      itemWidth:
                          MediaQuery.of(context).size.width - 2 * defaultMargin,
                      press: () {
                        // Navigator.of(context).pop();
                        Get.to(
                          () => ProductDetailsPage(
                            transaction: Transaction(
                              shop: item.shop,
                              product: item,
                              user: (context.read<UserCubit>().state
                                      is UserLoaded)
                                  ? (context.read<UserCubit>().state
                                          as UserLoaded)
                                      .user
                                  : null,
                            ),
                            onBackButtonPressed: () {
                              Get.back();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (context) =>
                      CustomIllustration(
                    picturePath: unexpectedError,
                    title: "Maaf",
                    subtitle: "Produk gagal dimuat",
                  ),
                  noItemsFoundIndicatorBuilder: (context) => CustomIllustration(
                    picturePath: notFound,
                    title: "Maaf",
                    subtitle: "Produk tidak ditemukan",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _updateSearchTerm(String searchTerm) {
    query = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
