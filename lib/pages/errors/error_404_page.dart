import 'package:flutter_blog_app/libs.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 12, 1),
        automaticallyImplyLeading: true,
        title: const Text('Erreur 404', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Page introuvable',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => context.goNamed(Routes.homeName),
                child: const Text(
                  "Retourner à l'accueil",
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}
