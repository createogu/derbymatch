import 'package:derbymatch/features/auth/controllers/user_me_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/models/user_model.dart';

class SuccessUserProfileScreen extends ConsumerWidget {
  const SuccessUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userMeProvider) as UserModel;
    return Scaffold(
      body: Container(
        child: Text(user.name),
      ),
    );
  }
}
