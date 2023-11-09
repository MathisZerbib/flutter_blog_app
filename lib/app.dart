import 'package:flutter_blog_app/libs.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
          initialLocation: Routes.homePath,
          navigatorKey: rootNavigatorKey,
          debugLogDiagnostics: true,
          errorBuilder: (BuildContext context, GoRouterState state) =>
              const ErrorPage(),
          routes: appRoutes),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}
