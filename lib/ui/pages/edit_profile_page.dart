part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage({this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic> error;

  @override
  void initState() {
    if (widget.user != null) {
      nameController.text = widget.user.name;
      phoneController.text = widget.user.phoneNumber;
      addressController.text = widget.user.address;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Edit Profil',
      subtitle: "Lengkapi data diri Anda",
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            LabelFormField(label: "Nama Anda"),
            TextFieldDefault(
                icon: Icons.person,
                controller: nameController,
                hintText: "Nama Anda"),
            TextDanger(error: error, param: "name"),
            SizedBox(height: 15),
            LabelFormField(label: "No HP", example: "Contoh: 0878785677"),
            TextFieldDefault(
                icon: MdiIcons.phone,
                controller: phoneController,
                hintText: "No HP"),
            TextDanger(error: error, param: "phoneNumber"),
            SizedBox(height: 15),
            LabelFormField(label: "Alamat"),
            TextFieldDefault(
                isPrefixIcon: false,
                isMaxLines: true,
                maxLines: 3,
                controller: addressController,
                hintText: "Alamat Anda"),
            TextDanger(error: error, param: "address"),
            // ErrorValidation(error: error),
            SizedBox(height: 15),
            ButtonDefault(
              isLoading: isLoading,
              title: "Simpan Data",
              press: () async {
                setState(() {
                  isLoading = true;
                });

                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    addressController.text.isEmpty) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar('Gagal ubah data', 'Mohon isi semua data', 'error');
                  return;
                } else if (!phoneController.text.isPhoneNumber) {
                  setState(() {
                    isLoading = false;
                  });
                  snackBar('Gagal ubah data', 'No HP tidak valid', 'error');
                  return;
                }
                  User user = User(
                    name: nameController.text,
                    address: addressController.text,
                    phoneNumber: phoneController.text,
                  );

                await context.read<UserCubit>().update(user, widget.user.id);

                UserState state = context.read<UserCubit>().state;

                if (state is UserLoaded) {
                  context.read<UserCubit>().getMyProfile(state.user.id);

                  Get.to(() => MainPage(
                        initialPage: 4,
                      ));
                  snackBar("Sukses", "Profil berhasil diupdate", 'success');

                  setState(() {
                    isLoading = false;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                } else {
                  context.read<UserCubit>().getMyProfile(widget.user.id);

                  snackBar("Profil gagal diupdate",
                      (state as UserLoadingFailed).message, 'error');

                  setState(() {
                    // error = (state as UserLoadingFailed).error != null
                    //     ? (state as UserLoadingFailed).error
                    //     : null;
                    isLoading = false;
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
