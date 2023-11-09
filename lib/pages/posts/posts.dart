import 'package:flutter_blog_app/libs.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/main_logo.png',
          width: 150,
          height: 150,
        ),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.homeName),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(Routes.homeName),
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Flutter Delayed
          await Future.delayed(const Duration(seconds: 2));
          AsyncValue<List<Post>> refreshedPosts =
              await ref.refresh(postsProvider);

          refreshedPosts;
        },
        child: _buildPostListView(ref),
      ),
    );
  }

  Widget _buildPostListView(WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsProvider);

    return postsAsyncValue.when(
      data: (List<Post> posts) {
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            Post post = posts[index];

            return BlogCard(
              title: post.title,
              author: post.userId.toString(),
              onClick: () {
                context.goNamed(
                  Routes.postDetailsName,
                  pathParameters: {'id': post.id.toString()},
                );
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          Center(child: Text('Error fetching posts: $error')),
    );
  }
}
