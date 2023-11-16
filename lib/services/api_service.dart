import 'package:http/http.dart' as http;
import 'package:flutter_blog_app/libs.dart';

class Api {
  static String unsplashApiKey = dotenv.env['UNSPLASH_API_KEY'] ?? '';

  /// POSTS
  static Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Post> posts = jsonList.map((json) => Post.fromJson(json)).toList();
        return posts;
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching posts: $e');
    }
  }

  static Future<Post> addPost(Post post) async {
    try {
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
    } catch (e) {
      throw Exception('An error occurred while adding a post: $e');
    }
  }

  static Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      throw Exception('An error occurred while deleting a post: $e');
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

  // IMAGES
  static Future<String> fetchUserPhoto(int userId) async {
    try {
      final String randomInt = Random().nextInt(10).toString();

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
        return "https://picsum.photos/id/$randomInt/720/1280";
      }
    } catch (e) {
      throw Exception('An error occurred while fetching user photo: $e');
    }
  }

  static Future<String> fetchPostImage(int postId) async {
    final randomInt = Random(postId).nextInt(5);

    const imageUrl = 'https://source.unsplash.com/random/1280x720';

    return imageUrl;
    // try {
    // final String randomInt = Random().nextInt(10).toString();

    //   final response = await http.get(
    //     Uri.parse('https://api.unsplash.com/photos/random'),
    //     headers: <String, String>{
    //       'Authorization': 'Client-ID $unsplashApiKey',
    //     },
    //   );
    //   if (response.statusCode == 200) {
    //     print('response.body ${response.body}');
    //     final Map<String, dynamic> photoData = jsonDecode(response.body);
    //     return photoData['urls']['regular'];
    //   } else {
    //     print('error${response.statusCode}');
    //     return "https://picsum.photos/id/$randomInt/720/1280";
    //   }
    // } catch (e) {
    //   throw Exception('An error occurred while fetching post image: $e');
    // }
  }

  Future<List<Comment>> fetchCommentsByPostId(int postId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/comments?postId=$postId'));
      final data = jsonDecode(response.body) as List<dynamic>;
      final comments =
          data.map((comment) => Comment.fromJson(comment)).toList();
      return comments;
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
