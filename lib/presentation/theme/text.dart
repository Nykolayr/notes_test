import 'package:flutter/material.dart';
import 'package:notes_test/presentation/theme/colors.dart';

/// Набор стилей текста для приложения.
///
/// Включает в себя стили для основных заголовков, полей ввода и обычного текста.
/// Позволяет обеспечить единообразие текстовых элементов по всему приложению.
/// t - общий, t38mw - 38px, 500w,   белый
class AppText {
  static const TextStyle t38mw = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w500,
    color: AppColor.white,
  );
  static const TextStyle t16rw = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );
  static const TextStyle t14rb = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
  );
  static const TextStyle t12rw = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );
  static const TextStyle t10rw = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );
}
