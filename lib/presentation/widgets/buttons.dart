import 'package:flutter/material.dart';
import 'package:notes_test/presentation/theme/theme.dart';

/// большая кнопка
class ButtonWide extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnable;
  final bool isBorder;
  final bool isWhite;
  const ButtonWide({
    required this.text,
    required this.onPressed,
    this.isEnable = true,
    this.isBorder = false,
    this.isWhite = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 52,
        decoration: BoxDecoration(
          color: isWhite ? AppColor.white : AppColor.orange,
          border: Border.all(
              color: isBorder ? AppColor.white : Colors.transparent, width: 1),
          borderRadius: AppDif.borderRadius13,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppText.t16rw
              .copyWith(color: isWhite ? AppColor.black : AppColor.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
