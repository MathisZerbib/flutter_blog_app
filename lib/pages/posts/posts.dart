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
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Padding for the whole page
        child: RefreshIndicator(
          onRefresh: () async {
            // Flutter Delayed
            await Future.delayed(const Duration(milliseconds: 00));
            AsyncValue<List<Post>> refreshedPosts =
                await ref.refresh(postsProvider);

            refreshedPosts;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Blog List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: _buildPostListView(ref),
              ),
            ],
          ),
        ),
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

            return Dismissible(
              key: Key(post.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${post.title} deleted"),
                    ),
                  );
                }
              },
              background: const Card(
                color: Colors.red,
                child: Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: PostCard(
                title: post.title,
                author: post.userId.toString(),
                onClick: () {
                  context.goNamed(
                    Routes.postDetailsName,
                    pathParameters: {'id': post.id.toString()},
                  );
                },
              ),
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
