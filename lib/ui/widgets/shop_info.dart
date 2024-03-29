part of 'widgets.dart';

class ShopInfo extends StatelessWidget {
  final Shop shop;

  ShopInfo({this.shop});

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
              "Informasi Toko",
              style: sectionTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              color: Colors.grey[100],
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Column(
                    children: [
                      ...ListTile.divideTiles(
                        color: Colors.black,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            leading: Icon(Icons.shop, size: 30, color: Colors.red),
                            title: Text(
                              "Nama Toko",
                              style: titleListStyle,
                            ),
                            subtitle: Text(
                              shop.name,
                              style: textListStyle,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(MdiIcons.mapMarker, size: 30, color: Colors.red),
                            title: Text("Alamat", style: titleListStyle),
                            subtitle: Text(shop.address, style: textListStyle),
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
