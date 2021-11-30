import 'dart:ui';

import 'package:flutter/material.dart';

class TextCustom {
  static heading1(
          {required String text,
          required Color? color,
          TextOverflow? overflow,
          int? maxLines}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 32,
            color: color,
            fontWeight: FontWeight.w700,
          ),
          overflow: overflow,
          maxLines: maxLines,
        ),
      );
  static heading2(
          {required String text,
          required Color? color,
          TextOverflow? overflow,
          int? maxLines}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            color: color,
            fontWeight: FontWeight.w700,
          ),
          overflow: overflow,
          maxLines: maxLines,
        ),
      );
  static heading3(
          {required String text,
          required Color? color,
          TextOverflow? overflow,
          int? maxLines}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: color,
            fontWeight: FontWeight.w700,
          ),
          overflow: overflow,
          maxLines: maxLines,
        ),
      );
  static paragraph1(
          {required String text,
          required Color? color,
          TextOverflow? overflow,
          int? maxLines}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: color,
          ),
          overflow: overflow,
          maxLines: maxLines,
        ),
      );
  static paragraph2(
          {required String text,
          required Color? color,
          TextOverflow? overflow,
          int? maxLines}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: color,
          ),
          overflow: overflow,
          maxLines: maxLines,
        ),
      );
}
