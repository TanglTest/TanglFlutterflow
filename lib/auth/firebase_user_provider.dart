import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TanglTestFirebaseUser {
  TanglTestFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

TanglTestFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TanglTestFirebaseUser> tanglTestFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TanglTestFirebaseUser>(
        (user) => currentUser = TanglTestFirebaseUser(user));
