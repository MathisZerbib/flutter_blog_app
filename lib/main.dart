import 'package:flutter_blog_app/libs.dart';

void main() async {
  await dotenv.load(fileName: 'lib/.env');
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
