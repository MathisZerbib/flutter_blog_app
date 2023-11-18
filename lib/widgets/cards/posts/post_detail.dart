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
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Image(image: NetworkImage('https://picsum.photos/800/400')),
            FutureBuilder(
              future: Api.fetchPostImage(widget.post.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image(
                    height: 400,
                    image: NetworkImage(snapshot.data.toString()),
                  );
                } else {
                  return const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              // leading: const CircleAvatar(
              //     backgroundImage: NetworkImage('https://picsum.photos/50/50')),
              leading: FutureBuilder(
                future: Api.fetchUserPhoto(widget.post.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.toString()),
                    );
                  } else {
                    return const CircleAvatar(
                      child: Icon(Icons.person),
                    );
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
            const Gap(40),
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
