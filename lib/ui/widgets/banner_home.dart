part of 'widgets.dart';

class BannerHome extends StatefulWidget {
  @override
  _BannerHomeState createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    bool isLogin = (context.watch<UserCubit>().state is UserLoaded);
    return BlocBuilder<SliderCubit, SliderState>(builder: (_, state) {
      if (state is SliderLoaded) {
        if (state.sliders.length == 0) {
          return welcome(context, isLogin);
        } else {
          return Container(
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              height:
                  (MediaQuery.of(context).size.width - 2 * defaultMargin) / 2.5,
              margin: EdgeInsets.symmetric(vertical: 16),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlayInterval: state.sliders.length < 2
                            ? null
                            : Duration(seconds: 7),
                        autoPlay: state.sliders.length < 2 ? false : true,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    items: state.sliders
                        .map(
                          (item) => Stack(children: <Widget>[
                            CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              imageUrl: item.images,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => loadingIndicator,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              repeat: ImageRepeat.repeat,
                            ),
                            state.sliders.length > 1
                                ? Positioned(
                                    bottom: 10.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: state.sliders.map((e) {
                                        int index = state.sliders.indexOf(e);
                                        return Flexible(
                                          child: Container(
                                            width: 8.0,
                                            height: 8.0,
                                            margin: EdgeInsets.only(
                                                right: 2.0, left: 2.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _current == index
                                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                                  : Color.fromRGBO(
                                                      0, 0, 0, 0.4),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                : SizedBox()
                          ]),
                        )
                        .toList(),
                  )));
        }
      } else if (state is SliderLoadingFailed) {
        return welcome(context, isLogin);
      } else {
        return Column(children: [
          SizedBox(height: 16),
          ShimmerRow(
              ratio: 0.9,
              itemCount: 1,
              isSymmetric: false,
              isCustomWidth: true,
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              height: (MediaQuery.of(context).size.width - 2 * defaultMargin) /
                  2.5),
          SizedBox(height: 16)
        ]);
      }
    });
  }
}

Container welcome(BuildContext context, bool isLogin) {
  return Container(
    // height: 90,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
    padding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 15,
    ),
    decoration: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text.rich(
      TextSpan(
        style: TextStyle(color: Colors.white),
        children: [
          TextSpan(
              text: isLogin
                  ? "Halo " +
                      (context.watch<UserCubit>().state as UserLoaded)
                          .user
                          .name +
                      "\n"
                  : "Selamat datang di aplikasi\n",
              style: GoogleFonts.poppins()),
          TextSpan(
            text: isLogin ? "Selamat datang" : "Doltinuku Gedawang",
            style: GoogleFonts.poppins().copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
