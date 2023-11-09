import 'package:flutter_blog_app/libs.dart';

final postsProvider = FutureProvider<List<Post>>((ref) async {
  List<Post> posts = await fetchPosts();
  return posts;
});
