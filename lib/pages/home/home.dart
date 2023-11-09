import 'package:flutter_blog_app/libs.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 12, 1),
        automaticallyImplyLeading: true,
        title: const Text('Le Monde', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          children: [
              Image.asset(
              'assets/le_monde_logo.png', // Replace with the actual path to your logo image
              width: 30,
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.postsName);
              },
              child: const Text('Bienvenue'),
            ),
          ],
        ),
      ),
    );
  }
}
