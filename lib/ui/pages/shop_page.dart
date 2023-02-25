part of 'pages.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController keywordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  AnimationController animationController;

  int length = 0;
  bool isLoading = false;
  ApiReturnValue<List<Shop>> newItems;
  String query;
  String message;

  static const _pageSize = 3;

  final PagingController<int, Shop> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    isLoading = true;
    countShops(null);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  void countShops(String query) async {
    isLoading = true;
    try {
      query ??= '';
      String url = baseURLAPI + 'shop?count=true&query=' + query;
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI
      });
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            var data = jsonDecode(response.body);
            length = data['data'];
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

  Future<void> _fetchPage(int pageKey) async {
    try {
      newItems = await ShopServices.getShops(pageKey, null, _pageSize, query);

      final isLastPage = newItems.value.length < _pageSize;
      if (isLastPage) {
        print('isLastPage');
        _pagingController.appendLastPage(newItems.value);
      } else {
        print('isNotLastPage');
        _pagingController.appendPage(newItems.value, pageKey + 1);
      }
    } catch (error) {
      _pagingController.error = error;
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
              // getAppBarUI(),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Row(
                            children: [
                              Container(width:
                              MediaQuery.of(context).size.width - 64,
                                padding: EdgeInsets.only(
                                    left: defaultMargin, right: 2, top: 8),

                                child: SearchField(
                                  onChanged: _updateSearchTerm,
                                  searchController: keywordController,
                                  title: "Cari toko",
                                ),
                              ),
                              RefreshButton(
                                press: () {
                                  _pagingController.refresh();
                                },
                              ),
                              // getSearchBarUI(),
                            ],
                          );
                        }, childCount: 1),
                      ),
                      // SliverPersistentHeader(
                      //   pinned: true,
                      //   floating: true,
                      //   delegate: ContestTabHeader(
                      //     GetRefreshBarUI(
                      //       length: length,
                      //       refresh: () {
                      //         _pagingController.refresh();
                      //       },
                      //     ),
                      //     message,
                      //   ),
                      // ),
                    ];
                  },
                  body: RefreshIndicator(
                    onRefresh: () => Future.sync(() {
                      _pagingController.refresh();
                    }),
                    child: PagedListView<int, Shop>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Shop>(
                        itemBuilder: (context, item, index) => Padding(
                          padding: EdgeInsets.only(top: 8),
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
                          picturePath: foodWishes,
                          title: "Maaf",
                          subtitle: "Toko gagal dimuat",
                        ),
                        noItemsFoundIndicatorBuilder: (context) =>
                            CustomIllustration(
                          picturePath: notFound,
                          title: "Maaf",
                          subtitle: "Toko tidak ditemukan",
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

class GetRefreshBarUI extends StatelessWidget {
  final int length;
  final Function refresh;
  GetRefreshBarUI({this.length, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: [
                // Expanded(
                //     child: Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(length.toString() + ' Toko ditemukan',
                //       style: blackFontStyle3),
                // )),
                RefreshButton(
                  isLabel: true,
                  press: refresh,
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}

class RefreshButton extends StatelessWidget {
  final Function press;
  final bool isLabel;
  RefreshButton({this.press, this.isLabel = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8),
          child: Row(
            children: [
              isLabel ? Text('Refresh', style: blackFontStyle3) : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.refresh, color: mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
