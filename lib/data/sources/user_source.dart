import 'dart:convert';

import 'package:flutter_game_challenge/data/entities/user.dart';
import 'package:flutter_game_challenge/data/sources/storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserSource {
  final List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  Future<User?> getUser() async {
    final user = await Storage.getUser();
    if (user != null) {
      return User.fromJson(jsonDecode(user));
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    await Storage.saveUser(jsonEncode(user.toJson()));
  }

  Future<void> logOut() async {
    await Storage.deleteUser();
  }

  Future<User?> googleSignIn() {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      // Optional clientId
      // clientId: 'your-client_id.apps.googleusercontent.com',
      scopes: scopes,
    );

    return _googleSignIn.signIn().then((GoogleSignInAccount? account) {
      if (account == null) return null;
      final user = User(
        email: account.email,
        id: account.id.hashCode,
        name: account.displayName ?? 'Gamer',
      );
      saveUser(user);
      return user;
    }).catchError((error) {
      print('Error: $error');
    });
  }
}
