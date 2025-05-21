import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_test/domain/routers/routers.dart';
import 'package:notes_test/presentation/theme/theme.dart';

class AppBarBazi extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final bool isBack;
  final bool isRight;

  const AppBarBazi({
    super.key,
    this.title = '',
    this.isBack = true,
    this.isRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.orange,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isBack)
            GestureDetector(
              child: const Icon(Icons.arrow_back, color: AppColor.white),
              onTap: () => context.pop(),
            ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: AppText.t16rw,
              ),
            ),
          ),
          isRight
              ? GestureDetector(
                  onTap: () {
                    router.goNamed('settings');
                  },
                  child: const Icon(Icons.settings, color: AppColor.white),
                )
              : const Gap(48),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
