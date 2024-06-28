import 'package:derbymatch/core/constants/constants.dart';
import 'package:derbymatch/features/splashscreen/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
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

  // Initialize the Intl package
  Intl.defaultLocale = 'ko_KR';
// 한국어 로케일 초기화
  timeago.setLocaleMessages('ko', timeago.KoMessages());
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
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider);
    final commonCode =
        ref.read(commCodeControllerProvider.notifier).fetchCommCodes();
    return commonCode != null
        ? MaterialApp.router(
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
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('ko', 'KR'), // Korean
            ],
          )
        : SplashScreen();
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
