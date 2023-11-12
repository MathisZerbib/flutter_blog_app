import 'package:flutter_blog_app/libs.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const homeName = 'home';
  static const homePath = '/$homeName';

  static const postsName = 'posts';
  static const postsPath = '/$postsName';

  static const userProfileName = 'user-profile';
  static const userProfilePath = '/$userProfileName';

  static const postDetailsName = 'post-details';
  static const postDetailsPath = '$postsPath/:id';
}

final appRoutes = [
  GoRoute(
    name: Routes.homeName,
    path: Routes.homePath,
    parentNavigatorKey: rootNavigatorKey,
    pageBuilder: (context, state) => NoTransitionPage(
      key: state.pageKey,
      child: const HomePage(),
    ),
  ),
  ShellRoute(
    navigatorKey: shellNavigatorKey,
    pageBuilder: (context, state, child) {
      return NoTransitionPage(child: Scaffold(body: child));
    },
    routes: [
      GoRoute(
        name: Routes.postsName,
        path: Routes.postsPath,
        parentNavigatorKey: shellNavigatorKey,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            NoTransitionPage(
          key: state.pageKey,
          child: const PostsPage(),
        ),
      ),
      GoRoute(
        name: Routes.postDetailsName,
        path: Routes.postDetailsPath,
        parentNavigatorKey: shellNavigatorKey,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final id = int.parse(state.pathParameters['id']!);
          return NoTransitionPage(
            key: state.pageKey,
            child: PostDetailsPage(id: id),
          );
        },
      ),
    ],
  ),
];
