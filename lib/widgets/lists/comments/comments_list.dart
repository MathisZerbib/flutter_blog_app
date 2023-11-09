import 'package:flutter_blog_app/libs.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;

  const CommentList({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        Comment comment = comments[index];
        return ListTile(
          title: Text(comment.name),
          subtitle: Text(comment.body),
          trailing: Text(
            '${Random().nextInt(30 + Random().nextInt(5))} days ago',
          ),
        );
      },
    );
  }
}
