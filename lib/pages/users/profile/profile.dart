import 'package:flutter_blog_app/libs.dart';

class UserProfilePage extends ConsumerWidget {
  final int id;

  const UserProfilePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/main_logo.png',
          width: 150,
          height: 150,
        ),
        leading: IconButton(
          onPressed: () => context.goNamed(Routes.homeName),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.goNamed(
              Routes.homeName,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Photo:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userProfile.photo),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Name:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: userProfile.name,
                      onChanged: (value) {
                        ref
                            .read(userProfileProvider(id).notifier)
                            .updateProfile(
                                userProfile.photo, value, userProfile.email);
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: userProfile.email,
                      onChanged: (value) {
                        ref
                            .read(userProfileProvider(id).notifier)
                            .updateProfile(
                                userProfile.photo, userProfile.name, value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
