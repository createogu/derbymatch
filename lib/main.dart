import 'package:derbymatch/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:routemaster/routemaster.dart';
import 'core/common/controllers/CommCodeController.dart';
import 'core/common/router/router.dart';
import 'core/theme/pallete.dart';
import 'features/auth/controllers/user_me_controller.dart';
import 'features/auth/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '${nativeAppKey}');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // 앱이 시작될 때 공통 코드를 로드
    ref.read(commCodeControllerProvider.notifier).fetchCommCodes();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '더비매치',
      theme: ref.watch(themeNotifierProvider),
      routerDelegate: RoutemasterDelegate(
        observers: [MyObserver()],
        routesBuilder: (context) {
          if (user != null) {
            if (user is UserModel) {
              return loggedInRoute;
            } else if (user is UserModelError) {
              return loggedOutRoute;
            } else {
              return loadingRoute;
            }
          }
          return loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

class MyObserver extends RoutemasterObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    print('Popped a route');
  }

  @override
  void didChangeRoute(RouteData routeData, Page page) {
    print('New route: ${routeData.path}');
  }
}
