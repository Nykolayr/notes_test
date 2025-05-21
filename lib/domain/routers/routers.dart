import 'package:go_router/go_router.dart';
import 'package:notes_test/common/function.dart';
import 'package:notes_test/presentation/screen/main/edit_note.dart';
import 'package:notes_test/presentation/screen/main/main_page.dart';
import 'package:notes_test/presentation/screen/settings/settings_page.dart';
import 'package:notes_test/presentation/screen/splash/splash.dart';
import 'package:page_transition/page_transition.dart';

/// роутер приложения
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  routes: <GoRoute>[
    GoRoute(
      name: 'splash',
      path: '/splash',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        type: PageTransitionType.fade,
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
      routes: <GoRoute>[
        GoRoute(
          name: 'main',
          path: '/main',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            type: PageTransitionType.leftToRight,
            context: context,
            state: state,
            child: const MainPage(),
          ),
          routes: <GoRoute>[
            GoRoute(
              name: 'editNote',
              path: '/editNote',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                type: PageTransitionType.leftToRight,
                context: context,
                state: state,
                child: const EditNotePage(),
              ),
            ),
            GoRoute(
              name: 'settings',
              path: '/settings',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                type: PageTransitionType.leftToRight,
                context: context,
                state: state,
                child: const SettingsPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
