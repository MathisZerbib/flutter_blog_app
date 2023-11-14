import 'package:flutter_blog_app/libs.dart';

class PostDetailCard extends StatefulWidget {
  final Post post;
  final List<Comment> comments;

  const PostDetailCard({
    Key? key,
    required this.post,
    required this.comments,
  }) : super(key: key);

  @override
  PostDetailCardState createState() => PostDetailCardState();
}

class PostDetailCardState extends State<PostDetailCard> {
  bool _isDataReady = false;

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  Future<void> _prepareData() async {
    await Api.fetchPostImage(widget.post.id);
    await Api.fetchUserPhoto(widget.post.userId);
    if (mounted) {
      setState(() {
        _isDataReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isDataReady ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: Api.fetchPostImage(widget.post.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching post image'));
                } else {
                  return Image.network(
                    snapshot.data.toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  );
                }
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 16.0,
                right: 16.0,
              ),
              leading: FutureBuilder(
                future: Api.fetchUserPhoto(widget.post.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.toString()),
                    );
                  } else {
                    return const CircleAvatar();
                  }
                },
              ),
              title: Text(
                widget.post.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('By User ${widget.post.userId}'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.post.body),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Plus récent',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            CommentList(comments: widget.comments),
          ],
        ),
      ),
    );
  }
}
