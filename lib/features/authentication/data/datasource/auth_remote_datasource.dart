import 'dart:developer';

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
}
