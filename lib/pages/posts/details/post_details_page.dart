import 'package:flutter_blog_app/libs.dart';

class PostDetailsPage extends ConsumerStatefulWidget {
  final int id;

  const PostDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  PostDetailsPageState createState() => PostDetailsPageState();
}

class PostDetailsPageState extends ConsumerState<PostDetailsPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final postAsyncValue = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/main_logo.png',
          width: 150,
          height: 150,
        ),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.postsName),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: postAsyncValue.when(
        data: (List<Post> posts) {
          int postIndex = posts.indexWhere((post) => post.id == widget.id);
          if (postIndex == -1) {
            postIndex = 0;
          }

          _pageController = PageController(initialPage: postIndex);

          return PageView.builder(
            controller: _pageController,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final commentProv = ref.read(commentsProvider.notifier);
              commentProv.fetchCommentsByPostId(index);
              final comments = ref.read(commentsProvider).comments;
              return Center(
                child: PostDetailCard(
                  post: post,
                  comments: comments,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error fetching post: $error')),
      ),
    );
  }
}
