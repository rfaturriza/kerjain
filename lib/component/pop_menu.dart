import 'package:flutter/material.dart';
import 'package:kerjain/utils/colors.dart';

class PopmenuCustom extends StatefulWidget {
  final Function? selectedItem;
  const PopmenuCustom({Key? key, this.selectedItem}) : super(key: key);

  @override
  _PopmenuCustomState createState() => _PopmenuCustomState();
}

class _PopmenuCustomState extends State<PopmenuCustom> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) => widget.selectedItem,
      initialValue: 2,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorsCustom.textDead, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.more_vert,
              color: ColorsCustom.textPrimary,
            ),
          ),
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem<int>(value: 0, child: Text("Ubah")),
        const PopupMenuItem<int>(value: 1, child: Text("Hapus")),
      ],
    );
  }
}
