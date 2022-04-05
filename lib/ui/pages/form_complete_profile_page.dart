part of 'pages.dart';

class FormCompleteProfilePage extends StatefulWidget {
  final Transaction transaction;

  FormCompleteProfilePage({this.transaction});

  @override
  _FormCompleteProfilePageState createState() =>
      _FormCompleteProfilePageState();
}

class _FormCompleteProfilePageState extends State<FormCompleteProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic> error;

  @override
  void initState() {
    if (widget.transaction.user != null) {
      nameController.text = widget.transaction.user.name;
      phoneController.text = widget.transaction.user.phoneNumber;
      addressController.text = widget.transaction.user.address;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Lengkapi Profile',
      subtitle: "Pastikan data yang diisi valid",
      onBackButtonPressed: () {
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            SizedBox(height: 15),
            LabelFormField(
              label: "Nama Anda",
            ),
            TextFieldDefault(
                icon: Icons.person,
                controller: nameController,
                hintText: "Nama Anda"),
            TextDanger(error: error, param: "name"),
            SizedBox(height: 15),
            LabelFormField(
              label: "No HP",
              example: "Contoh: 0878785677",
            ),
            TextFieldDefault(
                icon: MdiIcons.phone,
                controller: phoneController,
                hintText: "No HP"),
            TextDanger(error: error, param: "phoneNumber"),
            SizedBox(height: 15),
            LabelFormField(
              label: "Alamat",
            ),
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
                User user = User(
                  name: nameController.text,
                  address: addressController.text,
                  phoneNumber: phoneController.text,
                );

                setState(() {
                  isLoading = true;
                });

                await context.read<UserCubit>().update(user);

                UserState state = context.read<UserCubit>().state;
                if (state is UserLoaded) {
                  context.read<UserCubit>().getMyProfile();

                  Get.to(
                    () => PaymentPage(
                        transaction:
                            widget.transaction.copyWith(user: state.user)),
                  );
                  snackBar("Success", "Profile berhasil diupdate", 'success');

                  setState(() {
                    isLoading = false;
                  });
                } else {
                  context.read<UserCubit>().getMyProfile();
                  snackBar("Profile gagal diupdate",
                      (state as UserLoadingFailed).message, 'error');

                  setState(() {
                    error = (state as UserLoadingFailed).error != null
                        ? (state as UserLoadingFailed).error
                        : null;
                    isLoading = false;
                  });
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
