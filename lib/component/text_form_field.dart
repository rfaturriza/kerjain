import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormCustom extends StatelessWidget {
  final IconData? labelIcon;
  final String? labelIconText;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final int? maxLines;
  final Widget? icon;
  final String? Function(dynamic)? validator;
  final Function()? onTap;
  final bool readOnly;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  // ignore: use_key_in_widget_constructors
  const TextFormCustom({
    this.labelIcon,
    this.labelIconText,
    this.label,
    this.hintText,
    this.icon,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.initialValue,
    this.controller,
    this.maxLines,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (label != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    label!,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  (labelIcon != null)
                      ? PopupMenuButton(
                          initialValue: 1,
                          child: Icon(
                            labelIcon,
                            color: Colors.amber,
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                                value: 0, child: Text(labelIconText!)),
                          ],
                        )
                      : Container(),
                ],
              )
            : Container(),
        (label != null)
            ? const SizedBox(
                height: 5.0,
              )
            : Container(),
        TextFormField(
          initialValue: initialValue,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: icon,
            fillColor: const Color(0xfff3f3f4),
            border: InputBorder.none,
            filled: true,
            hintText: hintText,
          ),
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,
          controller: controller,
        ),
        (label != null)
            ? const SizedBox(
                height: 5.0,
              )
            : Container(),
      ],
    );
  }
}
