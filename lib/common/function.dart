import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

/// функция которая возращает null, если нет вхождений
T? findFirstWhereOrNull<T>(Iterable<T> items, bool Function(T) test) {
  for (final item in items) {
    if (test(item)) {
      return item;
    }
  }
  return null;
}

/// печать длинных строк
void prints(Object s1) {
  final s = s1.toString();
  final pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  pattern.allMatches(s).forEach((match) => print(match.group(0)));
}

/// функция создает различные анимации для переходов по страницам
CustomTransitionPage<dynamic> buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required PageTransitionType type,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    restorationId: state.pageKey.value,
    name: state.name,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        PageTransition(
      child: child,
      type: type,
    ).buildTransitions(context, animation, secondaryAnimation, child),
  );
}
