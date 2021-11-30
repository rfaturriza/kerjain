import 'package:flutter/material.dart';
import 'package:kerjain/utils/colors.dart';

class ButtonSecondary extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final bool isborder;
  final bool isStylish;

  const ButtonSecondary(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.isborder = true,
      this.isStylish = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
      child: Container(
        decoration: isStylish
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ColorsCustom.primary2, ColorsCustom.primary1]),
                boxShadow: [
                  BoxShadow(
                    color: ColorsCustom.primary2.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              )
            : const BoxDecoration(),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(isborder
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: ColorsCustom.textDead))
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
          child: child,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
