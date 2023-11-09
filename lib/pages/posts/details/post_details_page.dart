import 'package:flutter_blog_app/libs.dart';

class PostDetailsPage extends ConsumerStatefulWidget {
  final int id;
  const PostDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsPageState();
}

class _PostDetailsPageState extends ConsumerState<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final postAsyncValue = ref.watch(postProvider(widget.id));

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/main_logo.png',
          width: 150,
          height: 150,
        ),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.postsName),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: postAsyncValue.when(
        data: (Post post) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  post.body,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error fetching post: $error')),
      ),
    );
  }
}
