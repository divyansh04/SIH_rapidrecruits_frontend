import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchableDD extends StatelessWidget {
  final String hintText;
  final String label;
  final String selectedItem;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?) validate;
  final Color color;
  final bool showSearchBox;
  const SearchableDD(
      {Key? key,
      required this.hintText,
      required this.label,
      required this.selectedItem,
      required this.items,
      required this.onChanged,
      required this.validate,
      required this.color,
      this.showSearchBox = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      validator: validate,
      dropdownSearchDecoration: InputDecoration(
        hintText: label,
        labelStyle: const TextStyle(fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(30)),
      ),
      showSelectedItem: true,

      selectedItem: selectedItem,

      mode: Mode.DIALOG,
      showSearchBox: showSearchBox,
      label: label,

      items: items,
      //selectedItem: _con.city,
      onChanged: onChanged,
    );
  }
}
