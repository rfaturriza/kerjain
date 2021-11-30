import 'package:flutter/material.dart';
import 'package:kerjain/utils/colors.dart';

class CardPrimary extends StatelessWidget {
  final Widget child;
  const CardPrimary({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
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
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(child: child),
        ),
      ),
    );
  }
}
