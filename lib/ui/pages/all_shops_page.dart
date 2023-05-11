part of 'pages.dart';

class AllShopsPage extends StatefulWidget {
  @override
  _AllShopsPageState createState() => _AllShopsPageState();
}

class _AllShopsPageState extends State<AllShopsPage> {
  static const _pageSize = 5;
  final TextEditingController keywordController = TextEditingController();
  String query;

  final PagingController<int, Shop> _pagingController =
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
      final newItems =
          await ShopServices.getShops(null, pageKey, _pageSize, query);

      final isLastPage = newItems.value.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.value);
      } else {
        final nextPageKey = pageKey + newItems.value.length;
        _pagingController.appendPage(newItems.value, nextPageKey);
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
            SizedBox(height: 6),
            TitlePage(
              title: "Toko UMKM",
              subtitle: "Daftar semua UMKM",
              onBackButtonPressed: () {
                Get.back();
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: SearchField(
                onChanged: _updateSearchTerm,
                searchController: keywordController,
                title: "Cari toko",
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                      () => _pagingController.refresh(),
                ),
                child: PagedListView<int, Shop>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Shop>(
                    itemBuilder: (context, item, index) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultMargin / 4),
                      child: ShopCard(
                        shop: item,
                        press: () {
                          Get.to(
                                () => ShopDetailsPage(
                              transaction: Transaction(
                                  shop: item,
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
                    ),
                    firstPageErrorIndicatorBuilder: (context) =>
                        CustomIllustration(
                          picturePath: unexpectedError,
                          title: "Maaf",
                          subtitle: "Toko gagal dimuat",
                        ),
                    noItemsFoundIndicatorBuilder: (context) => CustomIllustration(
                      picturePath: notFound,
                      title: "Maaf",
                      subtitle: "Toko tidak ditemukan",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
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
