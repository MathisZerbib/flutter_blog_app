import 'package:flutter_blog_app/libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Image.asset(
          'assets/main_logo.png',
          width: 150,
          height: 150,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.postsName);
              },
              child: const Text('Voir le feed'),
            ),
          ],
        ),
      ),
    );
  }
}
