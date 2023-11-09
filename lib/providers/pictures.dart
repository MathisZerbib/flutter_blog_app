import 'package:flutter_blog_app/libs.dart';

final imagesProvider = FutureProvider<List<ImageModel>>((ref) async {
  // Simulated function to fetch image data
  // Replace this with your actual API call
  final List<Map<String, dynamic>> jsonData = await fetchImagesFromAPI();

  // Mapping the JSON data to ImageModel objects
  final List<ImageModel> images =
      jsonData.map((json) => ImageModel.fromJson(json)).toList();

  return images;
});

// Simulated function to fetch image data
// Replace this with your actual API call
Future<List<Map<String, dynamic>>> fetchImagesFromAPI() async {
  // Simulated JSON response
  final List<Map<String, dynamic>> jsonData = [
    {
      "albumId": 1,
      "id": 2,
      "title": "reprehenderit est deserunt velit ipsam",
      "url": "https://via.placeholder.com/600/771796",
      "thumbnailUrl": "https://via.placeholder.com/150/771796"
    },
    // Add more image data here if needed
  ];

  return Future.delayed(const Duration(seconds: 1), () => jsonData);
}
