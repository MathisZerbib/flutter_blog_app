import 'package:http/http.dart' as http;
import 'package:flutter_blog_app/libs.dart';

class Api {
  static String unsplashApiKey = dotenv.env['UNSPLASH_API_KEY'] ?? '';

  /// Posts API
  static Future<List<Post>> fetchPosts() async {
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

  static Future<Post> addPost(Post post) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add post');
    } else {
      return Post.fromJson(jsonDecode(response.body));
    }
  }

  static Future<void> deletePost(int id) async {
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

  static List<Post> searchPosts(List<Post> posts, String keyword) {
    return posts
        .where((post) =>
            post.title.toLowerCase().contains(keyword.toLowerCase()) ||
            post.body.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  static Post searchPostById(List<Post> posts, int id) {
    return posts.firstWhere((post) => post.id == id);
  }

// IMAGES API
  static Future<String> fetchUserPhoto(int userId) async {
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/photos/random'),
      headers: <String, String>{
        'Authorization': 'Client-ID $unsplashApiKey',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> photoData = jsonDecode(response.body);
      return photoData['urls']['regular'];
    } else {
      return 'https://via.placeholder.com/150';
    }
  }

  static Future<String> fetchPostImage(int postId) async {
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/photos/random'),
      headers: <String, String>{
        'Authorization': 'Client-ID $unsplashApiKey',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> photoData = jsonDecode(response.body);
      return photoData['urls']['regular'];
    } else {
      return 'https://via.placeholder.com/150';
    }
  }
}
