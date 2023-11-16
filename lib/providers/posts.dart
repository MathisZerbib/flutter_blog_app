import 'package:flutter_blog_app/libs.dart';

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final postsProvider = ref.read(postsNotifier);
  await postsProvider.fetchPosts();
  return postsProvider.posts;
});

final postsNotifier = ChangeNotifierProvider((ref) => PostsProvider());

class PostsProvider extends ChangeNotifier {
  final List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    final List<Post> newPosts = await Api.fetchPosts();

    final List<Post> postsToAdd = newPosts
        .where((newPost) =>
            !_posts.any((existingPost) => existingPost.id == newPost.id))
        .toList();

    _posts.addAll(postsToAdd);

    notifyListeners();
  }

  Future<void> addPost(Post post) async {
    final Post simulatedPost = post.copyWith(
        id: post.id, userId: 1, title: post.title, body: post.body);
    _posts.insert(0, simulatedPost);
    notifyListeners();
  }

  Future<void> deletePost(int id) async {
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
  }

  Post searchPostById(List<Post> posts, int id) {
    return posts.firstWhere((post) => post.id == id);
  }
}
