import 'package:flutter_blog_app/libs.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;

  CustomSearchDelegate(this.ref);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(ref, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(ref, query);
  }

  Widget _buildSearchResults(WidgetRef ref, String query) {
    final postsAsyncValue = ref.watch(postsProvider);

    return postsAsyncValue.when(
      data: (List<Post> posts) {
        final filteredPosts = posts
            .where((post) =>
                post.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (filteredPosts.isEmpty) {
          // Display a "no results" message in French
          return Center(
            child: Text(
              'Aucun résultat trouvé pour "$query"',
              style: const TextStyle(fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
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
                child: ListView.builder(
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    Post post = filteredPosts[index];
                    return _buildPostCard(context, post);
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          Center(child: Text('Error fetching posts: $error')),
    );
  }

  Widget _buildPostCard(BuildContext context, Post post) {
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
  }
}
