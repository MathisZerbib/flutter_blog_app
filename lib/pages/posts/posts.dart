import 'package:flutter_blog_app/libs.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: postsAsyncValue.when(
        data: (List<Post> posts) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              Post post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/post_details',
                    arguments: post,
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error fetching posts: $error')),
      ),
    );
  }
}
