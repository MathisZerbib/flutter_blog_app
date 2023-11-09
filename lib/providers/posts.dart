import 'package:flutter_blog_app/libs.dart';

final postsProvider = FutureProvider<List<Post>>((ref) async {
  List<Post> posts = await fetchPosts();
  return posts;
});

final postProvider = FutureProvider.family<Post, int>((ref, id) async {
  List<Post> posts = await ref.watch(postsProvider.future);
  Post post = searchPostById(posts, id);
  return post;
});

