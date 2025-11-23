import 'package:flutter/material.dart';
import '../api/auth_service.dart';

/// A provider class that manages authentication state and logic.
///
/// It uses the AuthService to communicate with Firebase and notifies the UI
/// about changes in state, such as loading status or user authentication.
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  /// Public getter to allow the UI to react to loading state changes.
  bool get isLoading => _isLoading;

  /// Private setter to control the loading state and notify listeners.
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<bool> isSignedIn() async {
    return (_authService.currentUser != null);
  }

  /// Attempts to sign in a user and manages the loading state.
  /// Returns true on success, false on failure.
  Future<bool> signIn({required String email, required String password}) async {
    _setLoading(true);
    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true; // Indicate success
    } catch (e) {
      _setLoading(false);
      return false; // Indicate failure
    }
  }

  /// Attempts to register a new user and manages the loading state.
  /// Returns true on success, false on failure.
  Future<bool> signUp({required String email, required String password}) async {
    _setLoading(true);
    try {
      await _authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    // No loading indicator needed for a quick operation like sign out.
    await _authService.signOut();
  }

  /// Attempts to change the user's password and manages loading state.
  /// Returns true on success, false on failure.
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _setLoading(true);
    try {
      await _authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  /// Attempts to send a password reset email and manages loading state.
  /// Returns true on success, false on failure.
  Future<bool> sendPasswordResetEmail({required String email}) async {
    _setLoading(true);
    try {
      await _authService.sendPasswordResetEmail(email: email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }
}
