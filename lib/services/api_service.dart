import 'package:http/http.dart' as http;
import 'package:flutter_blog_app/libs.dart';

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Post> posts = jsonList.map((json) => Post.fromJson(json)).toList();
    return posts;
  } else {
    throw Exception('Failed to fetch posts');
  }
}

Future<void> addPost(Post post) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(post.toJson()),
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to add post');
  }
}

Future<void> deletePost(int id) async {
  final response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to delete post');
  }
}

List<Post> searchPosts(List<Post> posts, String keyword) {
  return posts
      .where((post) =>
          post.title.toLowerCase().contains(keyword.toLowerCase()) ||
          post.body.toLowerCase().contains(keyword.toLowerCase()))
      .toList();
}
