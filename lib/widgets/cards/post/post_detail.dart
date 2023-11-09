import 'package:flutter/material.dart';

class BlogDetailCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String body;
  final List<Comment> comments;

  const BlogDetailCard({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.body,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('By $author • $date'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(body),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Comments',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              Comment comment = comments[index];
              return ListTile(
                title: Text(comment.name),
                subtitle: Text(comment.comment),
                trailing: Text(comment.date),
              );
            },
          ),
        ],
      ),
    );
  }
}

  class Comment {
    final String name;
    final String comment;
    final String date;

    Comment({
      required this.name,
      required this.comment,
      required this.date,
    });
  }
