import 'package:apart_forest/infrastructure/auth/auth_failure_or_success.dart';

class FirebaseAuthResult {
  final bool isSuccess;
  final AuthFailureOrSuccess authFailureOrSuccess;

  FirebaseAuthResult({
    this.isSuccess,
    this.authFailureOrSuccess,
  });
}
