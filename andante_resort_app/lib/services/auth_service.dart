import 'package:firebase_auth/firebase_auth.dart';

/// Firebase authentication helper.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.updateDisplayName(displayName);
    return credential;
  }

  Future<void> signOut() => _auth.signOut();

  /// Map Firebase auth error codes to user-facing messages.
  String messageFor(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found for that email.';
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'invalid-credential':
        return 'The email or password is incorrect. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'Please choose a stronger password (6+ characters).';
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'network-request-failed':
        return 'Please check your internet connection and try again.';
      case 'too-many-requests':
        return 'Too many requests. Please wait a moment and try again.';
      case 'user-disabled':
        return 'This account has been disabled.';
      default:
        return e.message
                    ?.replaceAll(RegExp(r'\[.*?\]'), '')
                    .trim()
                    .isNotEmpty ==
                true
            ? e.message!.replaceAll(RegExp(r'\[.*?\]'), '').trim()
            : 'Unable to sign in right now. Please try again.';
    }
  }
}
