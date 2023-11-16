import 'package:flutter_blog_app/libs.dart';

class CommentList extends StatelessWidget {
  final List<Comment> comments;

  const CommentList({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return comments.isEmpty
        ? const Center(
            child: Text(
              'No comments posted yet.',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          )
        : SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (context, index) {
                Comment comment = comments[index];
                return Column(
                  children: [
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            comment.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(comment.body),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'By ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: comment.email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      trailing: Text(
                        '${comment.id} days ago',
                      ),
                    ),
                    const Center(
                      child: SizedBox(
                        width: 400,
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
