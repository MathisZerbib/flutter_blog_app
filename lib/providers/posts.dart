import 'package:flutter_blog_app/libs.dart';

final postsProvider = FutureProvider((ref) => Api.fetchPosts());

class PostsProvider extends ChangeNotifier {
  final List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> addPost(Post post) async {
    _posts.add(post);
    notifyListeners();
  }

  Future<void> deletePost(int id) async {
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
  }

  /// filter post by Id and return the first post
  Post searchPostById(List<Post> posts, int id) {
    return posts.firstWhere((post) => post.id == id);
  }
}
