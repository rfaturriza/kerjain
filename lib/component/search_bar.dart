import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String? initialValue;
  final Function(String)? onChanged;

  final TextEditingController? controller;

  const SearchBar(
      {Key? key, this.initialValue, this.controller, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          fillColor: Color(0xfff3f3f4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintText: 'Cari kerjaan anda!'),
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }
}
