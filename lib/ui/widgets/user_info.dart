part of 'widgets.dart';

class UserInfo extends StatelessWidget {
  final User shopuser;
  final Function pressContact;

  UserInfo({this.shopuser,this.pressContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "Informasi Penjual",
              style: sectionTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    children: [
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.person),
                            title: Text("Nama", style: titleListStyle),
                            subtitle: Text(
                              shopuser.name,
                              style: textListStyle,
                            ),
                          ),
                          ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 12, right: 12, top: 10),
                            leading: Icon(Icons.phone),
                            title: Text("Kontak WA", style: titleListStyle),
                            subtitle: pressContact != null ? ButtonIconDefault(
                                title: "Hubungi Penjual",
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                press: pressContact,
                                height: 30,
                                color: "#128C7E".toColor(),
                                sizeIcon: 15,
                                sizeText: 12,
                                icon: MdiIcons.whatsapp) :
                            Text(shopuser.phoneNumber, style: textListStyle),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
