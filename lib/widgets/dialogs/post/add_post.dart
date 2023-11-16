import 'package:flutter_blog_app/libs.dart';

class AddPostDialog extends StatefulWidget {
  final WidgetRef ref;
  final Function(Post post) onAddPost;
  const AddPostDialog({Key? key, required this.ref, required this.onAddPost})
      : super(key: key);

  @override
  AddPostDialogState createState() => AddPostDialogState();
}

class AddPostDialogState extends State<AddPostDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add a new blog post',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Content'),
            maxLines: 3,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              final addedPost = await _savePost(widget.ref);
              widget.onAddPost(addedPost!);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<Post?> _savePost(WidgetRef ref) async {
    final String title = _titleController.text;
    final String content = _contentController.text;
    final Post post = Post(
      id: 0,
      userId: 1,
      title: title,
      body: content,
    );
    final posts = ref.read(postsNotifier);
    await posts.addPost(post);
    return post;
  }
}
