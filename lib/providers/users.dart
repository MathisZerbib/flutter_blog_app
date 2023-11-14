import 'package:flutter_blog_app/libs.dart';

final userProfileProvider =
    StateNotifierProvider.family<UserProfileNotifier, UserProfile, int>(
        (ref, id) {
  return UserProfileNotifier(id);
});

class UserProfileNotifier extends StateNotifier<UserProfile> {
  final int id;

  UserProfileNotifier(this.id)
      : super(UserProfile(
          photo: 'https://via.placeholder.com/150',
          name: 'John Doe',
          email: 'johndoe@example.com',
        ));

  void updateProfile(String photo, String name, String email) {
    state = UserProfile(photo: photo, name: name, email: email);
  }
}
