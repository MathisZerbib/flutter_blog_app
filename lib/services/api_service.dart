import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch posts');
  }
}
