import 'package:flutter_blog_app/libs.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await dotenv.load(fileName: 'lib/.env');
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(
    const Duration(milliseconds: 1500),
    () => FlutterNativeSplash.remove(),
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
