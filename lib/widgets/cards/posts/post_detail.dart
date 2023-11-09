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
  late Future<void> _data;

  @override
  void initState() {
    super.initState();
    _data = _prepareData();
  }

  Future<void> _prepareData() async {
    await fetchPostImage(widget.post.id);
    await fetchUserPhoto(widget.post.userId);
    // Other asynchronous operations
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: fetchPostImage(widget.post.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error fetching post image'));
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
                    future: fetchUserPhoto(widget.post.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircleAvatar();
                      } else if (snapshot.hasError) {
                        return const CircleAvatar();
                      } else {
                        return CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data.toString()),
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
                        'More recent first',
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
          );
        }
      },
    );
  }
}
