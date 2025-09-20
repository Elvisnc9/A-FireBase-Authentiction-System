// auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFormState {
  final String email;
  final String password;
  final String confirmPassword;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool success;
  final bool isLoading;

  AuthFormState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.success = false,
    this.isLoading = false,
  });

  AuthFormState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool? success,
    bool? isLoading,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      success: success ?? this.success,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthFormNotifier extends StateNotifier<AuthFormState> {
  AuthFormNotifier() : super(AuthFormState());

  static final _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // ---------- UPDATE FIELDS ----------
  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      emailError: _validateEmail(email),
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordError: _validatePassword(password),
      confirmPasswordError: state.confirmPassword.isEmpty
          ? null
          : _validateConfirmPassword(state.confirmPassword, password),
    );
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordError:
          _validateConfirmPassword(confirmPassword, state.password),
    );
  }

  // ---------- VALIDATORS ----------
  String? _validateEmail(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!_emailRegExp.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _validateConfirmPassword(String value, String password) {
    if (value.isEmpty) return 'Confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }






  // ---------- AUTH METHODS ----------
  Future<void> signUp(BuildContext context) async {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);
    final confirmPasswordError =
        _validateConfirmPassword(state.confirmPassword, state.password);

    if (emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      state = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password,
      );

      state = state.copyWith(success: true, isLoading: false);
      Navigator.pushReplacementNamed(context, '/LogIn');
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuth Error: code=${e.code}, message=${e.message}');
      state = state.copyWith(isLoading: false);

      state = state.copyWith(
        emailError: _mapErrorCodeToMessage(e.code),
        passwordError: (e.code == 'weak-password')
            ? 'Password is too weak'
            : state.passwordError,
      );
    }
  }

  Future<void> login(BuildContext context) async {
    final emailError = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);

    if (emailError != null || passwordError != null) {
      state = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password.trim(),
      );

      state = state.copyWith(success: true, isLoading: false);
      Navigator.pushReplacementNamed(context, '/Home');
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);

      if (e.code == 'user-not-found') {
        state = state.copyWith(emailError: 'No account found for this email');
      } else if (e.code == 'wrong-password') {
        state = state.copyWith(passwordError: 'Incorrect password');
      } else if (e.code == 'too-many-requests') {
        state = state.copyWith(emailError: 'Too many attempts. Try again later');
      } else {
        state = state.copyWith(emailError: _mapErrorCodeToMessage(e.code));
      }
    }
  }

String _mapErrorCodeToMessage(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Invalid email address';
    case 'email-already-in-use':
      return 'This email is already registered';
    case 'weak-password':
      return 'Password is too weak';
    case 'user-disabled':
      return 'This account has been disabled';
    case 'wrong-password':
      return 'Incorrect password';
    case 'user-not-found':
      return 'No account found for this email';
    case 'too-many-requests':
      return 'Too many attempts. Try again later';
    case 'invalid-credential':
      return 'Your email or password is incorrect';
    default:
      return 'Authentication failed (code: $code)';
  }
}

}

final authFormProvider =
    StateNotifierProvider<AuthFormNotifier, AuthFormState>(
  (ref) => AuthFormNotifier(),
);
