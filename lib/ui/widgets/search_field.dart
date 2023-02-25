part of 'widgets.dart';

class SearchField extends StatelessWidget {
  final Function press;
  final Function onChanged;
  final String title;
  final FocusNode focusNode;
  final TextEditingController searchController;

  SearchField(
      {this.title = "Cari sesuatu",
      this.onChanged,
      this.focusNode,
      this.searchController,
      this.press});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(7.0),
        child: TextField(
          onTap: press != null ? press : null,
          focusNode: focusNode,
          onChanged: onChanged,
          style: blackFontStyle3,
          controller: searchController,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            hintText: title,
            hintStyle: hintStyle,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
