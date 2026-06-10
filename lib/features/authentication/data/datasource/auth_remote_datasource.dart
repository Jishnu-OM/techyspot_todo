import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasource {
  final SupabaseClient supabase = Supabase.instance.client;

  AuthRemoteDatasource();

  Future<void> login({required String email, required String password}) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      log('login successful');
    } on AuthException catch (e) {
      log('error: $e');
      throw Exception(e.message);
    } catch (_) {
      log('Something went wrong. Please try again.');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      log('logout successful');
    } on AuthException catch (e) {
      log('error: $e');
      throw Exception(e.message);
    } catch (_) {
      log('Failed to logout. Please try again.');
      throw Exception('Failed to logout. Please try again.');
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final googleAuth = await googleUser.authentication;

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken!,
      );
    } catch (e) {
      log('error: $e');
      throw Exception(e);
    }
  }
}
