import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/pallete.dart';
import '../../auth/controllers/auth_controller.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({Key? key}) : super(key: key);

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _signOut() async {
      final provider = ref.read(authProvider);
      provider.logout();
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text('111'),
          ),
          listTextIconButton(
            buttonName: "로그아웃",
            p_method: _signOut,
          ),
          Text('테마변경'),
          Switch.adaptive(
            value: ref.watch(themeNotifierProvider.notifier).mode ==
                ThemeMode.dark,
            onChanged: (val) => toggleTheme(ref),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

class listTextIconButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback p_method;

  const listTextIconButton({
    required this.buttonName,
    required this.p_method,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: TextButton.icon(
        style: ButtonStyle(
          iconColor: MaterialStatePropertyAll<Color>(Pallete.primaryColor),
        ),
        onPressed: () {
          print("object");
          p_method();
        },
        icon: Icon(Icons.logout_outlined),
        label: Text(
          buttonName,
          style: AppTextStyles.bodyTextStyle.copyWith(
            color: Pallete.whiteColor,
          ),
        ),
      ),
    );
  }
}
