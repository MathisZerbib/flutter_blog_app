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
