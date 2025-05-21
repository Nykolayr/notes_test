import 'package:flutter/material.dart';
import 'package:notes_test/presentation/theme/theme.dart';

class WrapOrange extends StatelessWidget {
  final Widget child;

  const WrapOrange({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.orange,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
