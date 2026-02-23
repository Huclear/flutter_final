import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_sharing/data/repositories/shared_prefs_storage.dart';
import 'package:recipe_sharing/domain/firestore_collections.dart';
import 'package:recipe_sharing/domain/models/auth_result.dart';
import 'package:recipe_sharing/domain/models/creators/profile_request.dart';
import 'package:recipe_sharing/domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  Future<AuthResult<Map<String, String>>> authorize() async {
    if (await SharedPreferencesService.isUserLoggedIn()) {
      var data = await SharedPreferencesService.getCurrentUser();
      if (data['userId'] == null) {
        return AuthResultError(info: "Could not find info about user id");
      }
      return AuthResultAuthorized(
        data: data.map((key, value) => MapEntry(key, value ?? '')),
      );
    } else {
      return AuthResultUnauthorized();
    }
  }

  @override
  Future<AuthResult<Map<String, String>>> logIn({
    required String login,
    required String password,
  }) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: login,
        password: password,
      );

      return AuthResultAuthorized(
        data: {
          'userId': user.user?.uid ?? '',
          'userEmail': user.user?.email ?? '',
        },
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return AuthResultError(info: 'The email address is badly formatted.');
        case 'user-disabled':
          return AuthResultError(
            info: 'This user has been disabled. Please contact support.',
          );
        case 'user-not-found':
          return AuthResultError(info: 'No user found with this email.');
        case 'wrong-password':
          return AuthResultError(info: 'Wrong password provided for that user.');
        case 'invalid-credential':
          return AuthResultError(
            info: 'Invalid credentials. Please check your email and password.',
          );
        case 'too-many-requests':
          return AuthResultError(
            info:
                'Too many unsuccessful login attempts. Please try again later.',
          );
        case 'network-request-failed':
          return AuthResultError(
            info: 'Network error. Please check your internet connection.',
          );
        default:
          return AuthResultError(info: 'Unknown error. Please, try again later');
      }
    } catch (e) {
      return AuthResultError(info: "Unknown error. Please, try again later");
    }
  }

  @override
  Future<AuthResult<Map<String, String>>> register({
    required String login,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user == null) {
        return AuthResultError(info: "Could not obtain user info.");
      }
      var profile = ProfileRequest(
        userID: user.user!.uid,
        nickname: login,
        aboutMe: '',
        imageUrl: '',
        email: email,
        emailConfirmed: user.user!.emailVerified,
      );

      _store
          .collection(FirestoreCollections.creators.collectionName)
          .doc(user.user!.uid)
          .set(profile.toMap());

      return AuthResultAuthorized(
        data: {'userId': user.user!.uid, 'userEmail': user.user!.email ?? ''},
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return AuthResultError(info: 'The email address is badly formatted.');
        case 'user-disabled':
          return AuthResultError(
            info: 'This user has been disabled. Please contact support.',
          );
        case 'user-not-found':
          return AuthResultError(info: 'No user found with this email.');
        case 'wrong-password':
          return AuthResultError(info: 'Wrong password provided for that user.');
        case 'invalid-credential':
          return AuthResultError(
            info: 'Invalid credentials. Please check your email and password.',
          );
        case 'too-many-requests':
          return AuthResultError(
            info:
                'Too many unsuccessful login attempts. Please try again later.',
          );
        case 'network-request-failed':
          return AuthResultError(
            info: 'Network error. Please check your internet connection.',
          );
        default:
          return AuthResultError(info: 'Unknown error. Please, try again later');
      }
    } catch (e) {
      return AuthResultError(info: "Unknown error. Please, try again later");
    }
  }
}
