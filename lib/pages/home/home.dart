import 'package:flutter_blog_app/libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 12, 1),
        automaticallyImplyLeading: true,
        title: const Text('Blog Posts', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/main_logo.png',
              width: 150,
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.postsName);
              },
              child: const Text('Bienvenue'),
            ),
          ],
        ),
      ),
    );
  }
}
