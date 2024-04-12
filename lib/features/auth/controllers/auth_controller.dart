import 'package:derbymatch/features/auth/controllers/user_me_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref: ref));

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen(userMeProvider, (previous, next) {
      if (previous != next) {
        //ChangeNotifier에 정의되어 있는 고유함수
        notifyListeners();
      }
    });
  }

  logout() {
    ref.read(userMeProvider.notifier).logout();
  }
}
