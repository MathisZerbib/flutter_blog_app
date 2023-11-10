import 'package:flutter_blog_app/libs.dart';

class AddPostDialog extends StatefulWidget {
  final WidgetRef ref;

  const AddPostDialog({Key? key, required this.ref}) : super(key: key);

  @override
  AddPostDialogState createState() => AddPostDialogState();
}

class AddPostDialogState extends State<AddPostDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('AddPostDialogState.build()');
    print(widget.ref);
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
            onPressed: () {
              // Save the post using the provided ref and close the dialog.
              _savePost(widget.ref);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _savePost(WidgetRef ref) async {
    // Get the title and content from the controllers
    final String title = _titleController.text;
    final String content = _contentController.text;

    // Create a new post
    final Post post = Post(
      id: 0,
      userId: 1,
      title: title,
      body: content,
    );
    final postsProv = ref.watch(postsProvider);

    // Add the post to the posts provider
    // await postsProv.addPost(post);
  }
}
