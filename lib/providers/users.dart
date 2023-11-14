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
          photo:
              'https://conseilscrypto.com/wp-content/uploads/2023/07/Larry-Fink-PDG-du-geant-de-la-finance-BlackRock-declare-que-le-monde-de-la-crypto-numerise-lor.jpg',
          name: 'John Doe',
          email: 'johndoe@example.com',
        ));

  void updateProfile(String photo, String name, String email) {
    state = UserProfile(photo: photo, name: name, email: email);
  }
}
