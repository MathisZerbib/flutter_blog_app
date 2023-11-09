import 'package:flutter_blog_app/libs.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Go to Post Details'),
        ),
      ),
    );
  }
}
