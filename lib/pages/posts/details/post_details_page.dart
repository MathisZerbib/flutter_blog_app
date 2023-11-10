import 'package:flutter_blog_app/libs.dart';

class PostDetailsPage extends ConsumerStatefulWidget {
  final int id;
  const PostDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends ConsumerState<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final postAsyncValue = ref.watch(postsProvider);

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
        data: (List<Post> posts) {
          final post = PostsProvider().searchPostById(posts, widget.id);
          return Center(
            child: PostDetailCard(post: post, comments: [
              Comment(
                id: 1,
                postId: 1,
                name: 'Valentin',
                email: 'valentin@gmail.com',
                body: 'Test',
              ),
              Comment(
                id: 2,
                postId: 1,
                name: 'Mathis',
                email: 'mathis.zerbib@gmail.com',
                body: 'Test',
              ),
            ]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error fetching post: $error')),
      ),
    );
  }
}
