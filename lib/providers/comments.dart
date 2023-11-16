import 'package:flutter_blog_app/libs.dart';

final commentsProvider = ChangeNotifierProvider<CommentProvider>((ref) {
  return CommentProvider();
});

class CommentProvider extends ChangeNotifier {
  final List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchCommentsByPostId(int postId) async {
    final List<Comment> fetchedComments =
        await Api().fetchCommentsByPostId(postId);

    _comments.clear();
    _comments.addAll(fetchedComments);
    notifyListeners();
  }
}
