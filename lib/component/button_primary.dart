import 'package:flutter/material.dart';
import 'package:kerjain/utils/colors.dart';

class ButtonPrimary extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  const ButtonPrimary({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [ColorsCustom.secondary2, ColorsCustom.secondary1])),
          child: TextButton(
            onPressed: onPressed,
            child: child,
          ),
        ));
  }
}
