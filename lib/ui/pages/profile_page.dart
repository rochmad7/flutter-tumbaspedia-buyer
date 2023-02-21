part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isLogin = (context.watch<UserCubit>().state is UserLoaded);
    User user =
        isLogin ? (context.watch<UserCubit>().state as UserLoaded).user : null;
    return ListView(
      children: [
        Column(
          children: [
            //// Header
            isLogin
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    height: 300,
                    margin: EdgeInsets.only(bottom: defaultMargin),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/user/photo_border.png'))),
                          child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                ),
                              ),
                            ),
                            imageUrl: user.profilePicture,
                            fit: BoxFit.cover,
                            // placeholder: (context, url) =>
                            //     CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            repeat: ImageRepeat.repeat,
                          ),
                        ),
                        Text(
                          (context.watch<UserCubit>().state as UserLoaded)
                              .user
                              .name,
                          style: GoogleFonts.roboto(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.email,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.phoneNumber,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.address,
                          style: greyFontStyle.copyWith(
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  )
                : TitlePage(
                    title: "Pengaturan",
                    subtitle: "Pengaturan Akun Tumbaspedia",
                    isContainer: true),
            //// Body
            Container(
              width: double.infinity,
              color: Colors.white,
              child: isLogin
                  ? Column(
                      children: [
                        // CustomTabBar(
                        //   titles: ["Akun", "Tumbaspedia"],
                        //   selectedIndex: selectedIndex,
                        //   onTap: (index) {
                        //     setState(() {
                        //       selectedIndex = index;
                        //     });
                        //   },
                        // ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: [
                            {
                              'name': 'Edit Profil',
                              'press': EditProfilePage(user: user)
                            },
                            {
                              'name': 'Ubah Kata Sandi',
                              'press': ChangePasswordPage(user: user)
                            },
                            {'name': 'Tentang Kami', 'press': AboutPage()},
                            {
                              'name': 'Bantuan',
                              'press': HelpPage(),
                            },
                            // {
                            //   'name': 'Kebijakan Privasi',
                            //   'press': PrivacyPage(),
                            // },
                          ]
                              .map((e) => GestureDetector(
                                    onTap: () => Get.to(e['press']),
                                    child: SettingTitle(title: e['name']),
                                  ))
                              .toList(),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await context.read<UserCubit>().logOut();

                            Get.to(() => MainPage(initialPage: 4));

                            snackBar("Success", "Anda telah berhasil logout",
                                'success');
                          },
                          child: Column(
                            children: [
                              SettingTitle(
                                title: "Keluar",
                                isCustomStyle: true,
                                style: GoogleFonts.roboto(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: [
                            {'name': 'Masuk', 'press': SignInPage()},
                            {'name': 'Daftar Akun Baru', 'press': SignUpPage()},
                            {
                              'name': 'Lupa Kata Sandi',
                              'press': ForgotPasswordPage()
                            },
                            {'name': 'Tentang Kami', 'press': AboutPage()},
                            {'name': 'Bantuan', 'press': HelpPage()},
                          ]
                              .map((e) => GestureDetector(
                                    onTap: () => Get.to(e['press']),
                                    child: SettingTitle(title: e['name']),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
            ),
            // SizedBox(height: 10),
            // Center(child: Text("Versi 1.0", style: blackFontStyle)),

            SizedBox(
              height: 50,
            ),
            Container(
              height: 150,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {
                        launch("https://www.facebook.com/profile.php?id=100069886188294&mibextid=ZbWKwL");
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.squareFacebook,
                          ),
                          Text(
                            " Gerai Kopimi Rowosari",
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        launch("https://instagram.com/paguyubanumkmrowosari_semarang");
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.pink,
                          ),
                          Text(
                            " gerai_kopimi.rowosari",
                            style: GoogleFonts.roboto(
                                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SettingTitle extends StatelessWidget {
  final String title;
  final bool isCustomStyle;
  final TextStyle style;

  SettingTitle({this.title, this.isCustomStyle = false, this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 16, left: defaultMargin, right: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: isCustomStyle ? style : blackFontStyle3,
          ),
          SizedBox(
            height: defaultMargin,
            width: defaultMargin,
            child: Image.asset(
              'assets/icons/right_arrow.png',
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
