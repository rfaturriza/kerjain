import 'package:flutter/material.dart';
import 'package:kerjain/utils/colors.dart';

class CardSecondary extends StatelessWidget {
  final Widget child;
  final Color? color;
  final bool isborder;
  final Function() onPressed;
  const CardSecondary(
      {Key? key,
      required this.child,
      this.color,
      this.isborder = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.4,
          decoration: isborder
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: ColorsCustom.textDead, width: 2),
                  color: color,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: color,
                ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
