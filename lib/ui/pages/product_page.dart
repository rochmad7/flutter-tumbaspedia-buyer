part of 'pages.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController keywordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  int selectedIndex = -1;
  SortMethod _selectedSortMethod = SortMethod.acak;
  String message;
  String query;
  List<Category> categories;
  var category = <Category>[];
  AnimationController animationController;

  static const _pageSize = 8;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    fetchCategories();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      ApiReturnValue<List<Product>> newItems;
      if (selectedIndex == 0) {
        newItems = await ProductServices.getProducts(
            query, pageKey, _pageSize, null, null, _selectedSortMethod);
      } else {
        newItems = await ProductServices.getProducts(query, pageKey, _pageSize,
            selectedIndex, null, _selectedSortMethod);
      }

      final isLastPage = newItems.value.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.value);
      } else {
        _pagingController.appendPage(newItems.value, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void fetchCategories() async {
    isLoading = true;
    try {
      final response =
          await http.get(Uri.parse(baseURLAPI + '/categories'), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            var data = jsonDecode(response.body);
            categories = (data['data'] as Iterable)
                .map((e) => Category.fromJson(e))
                .toList();
            category.clear();
            category.addAll(categories);
            // if (!category.contains(mockCategories[0])) {
            //   category.insert(0, mockCategories[0]);
            // }
            isLoading = false;
          });
        }
      }
    } on SocketException {
      setState(() {
        message = socketException;
      });
    } on HttpException {
      setState(() {
        message = httpException;
      });
    } on FormatException {
      setState(() {
        message = formatException;
      });
    } catch (e) {
      setState(() {
        message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          splashColor: Colors.white,
          focusColor: Colors.white,
          highlightColor: Colors.white,
          hoverColor: Colors.white,
          onTap: () {},
          child: Column(
            children: [
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 64,
                                    padding: EdgeInsets.only(
                                        left: defaultMargin, right: 2, top: 8),
                                    child: SearchField(
                                      onChanged: _updateSearchTerm,
                                      searchController: keywordController,
                                      title: "Temukan Produk UKM",
                                    ),
                                  ),
                                  RefreshButton(
                                    press: () {
                                      _pagingController.refresh();
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  // getSearchBarUI(),
                                ],
                              ),
                              SizedBox(height: 10),
                              SortMethodGroup(
                                  selectedItem: _selectedSortMethod,
                                  onOptionTap: (option) {
                                    setState(
                                      () => _selectedSortMethod = option.id,
                                    );
                                    _pagingController.refresh();
                                  }),
                              SizedBox(height: 10),
                            ],
                          );
                        }, childCount: 1),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: ContestTabHeader(
                          Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: defaultMargin,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          offset: const Offset(0, -2),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  color: Colors.grey[100],
                                  child: message != null
                                      // ? Text(message)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: defaultMargin,
                                                      vertical:
                                                          defaultFontSize / 2),
                                                  child: Text(
                                                    message,
                                                    style: redFontStyle,
                                                  )),
                                            ),
                                          ],
                                        )
                                      : (isLoading)
                                          ? Container(
                                              margin: EdgeInsets.only(top: 20),
                                              color: Colors.white,
                                              child: ShimmerRow(
                                                  ratio: 1,
                                                  itemCount: 4,
                                                  color: Colors.white,
                                                  isSymmetric: false,
                                                  height: 30))
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: defaultMargin,
                                                        bottom: 10,),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedIndex =
                                                                  -1;
                                                            });
                                                            _pagingController
                                                                .refresh();
                                                          },
                                                          child: Container(
                                                            width: 60,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              color: (selectedIndex ==
                                                                      -1)
                                                                  ? mainAccentColor
                                                                  : Colors
                                                                      .transparent,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Semua",
                                                                style: (selectedIndex ==
                                                                        -1)
                                                                    ? whiteFontStyle
                                                                        .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      )
                                                                    : greyFontStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   margin: EdgeInsets.only(
                                                  //       left: defaultMargin,
                                                  //       right: 0),
                                                  //   child: Container(
                                                  //     width: 60,
                                                  //     height: 30,
                                                  //     decoration: BoxDecoration(
                                                  //       borderRadius: BorderRadius.circular(8),
                                                  //       color: (selectedIndex == -1)
                                                  //           ? mainAccentColor
                                                  //           : Colors.transparent,
                                                  //     ),
                                                  //     child: Center(
                                                  //       child: Text(
                                                  //         "Semua",
                                                  //         style: (selectedIndex == -1)
                                                  //             ? whiteFontStyle.copyWith(
                                                  //                 fontWeight: FontWeight.w500,
                                                  //               )
                                                  //             : greyFontStyle,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  for (var i = 0;
                                                      i < category.length;
                                                      i++)
                                                    ItemTabBar(
                                                      left: defaultMargin,
                                                      right: (category[i] ==
                                                              category.last)
                                                          ? 10
                                                          : 0,
                                                      category: category[i],
                                                      selectedIndex:
                                                          selectedIndex,
                                                      onTap: (index) {
                                                        setState(() {
                                                          selectedIndex = index;
                                                        });
                                                        _pagingController
                                                            .refresh();
                                                      },
                                                    ),
                                                ],
                                              ),

                                            )),
                              const Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Divider(
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          message,
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    color: Colors.white,
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => _pagingController.refresh(),
                      ),
                      child: PagedGridView<int, Product>(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                        pagingController: _pagingController,
                        showNewPageErrorIndicatorAsGridChild: false,
                        showNoMoreItemsIndicatorAsGridChild: false,
                        showNewPageProgressIndicatorAsGridChild: false,
                        builderDelegate: PagedChildBuilderDelegate<Product>(
                          itemBuilder: (context, item, index) => ProductCard(
                            product: item,
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
                          firstPageErrorIndicatorBuilder: (context) =>
                              CustomIllustration(
                            picturePath: foodWishes,
                            title: "Maaf",
                            subtitle: "Produk gagal dimuat",
                          ),
                          noItemsFoundIndicatorBuilder: (context) =>
                              CustomIllustration(
                            picturePath: notFound,
                            title: "Maaf",
                            subtitle: "Produk tidak ditemukan",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }

  void _updateSearchTerm(String searchTerm) {
    query = searchTerm;
    _pagingController.refresh();
  }

// @override
// void dispose() {
//   _pagingController.dispose();
//   super.dispose();
// }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
    this.message,
  );

  final String message;
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => message != null ? 102.0 : 52;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
