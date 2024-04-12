// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:routemaster/routemaster.dart';
//
// import '../../../core/common/controllers/MenuAppController.dart';
// import '../../../core/constants/constants.dart';
// import '../../../core/layout/responsive.dart';
// import '../../../core/values/values.dart';
// import '../widgets/side_menu.dart';
//
// class MainScreen extends ConsumerStatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends ConsumerState<MainScreen> {
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // 여기서 각 탭에 해당하는 라우트로 이동합니다.
//     switch (index) {
//       case 0:
//         Routemaster.of(context).push('/home');
//         break;
//       case 1:
//         Routemaster.of(context).push('/profile');
//         break;
//       // 추가 탭에 대한 경로를 설정할 수 있습니다.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final menuAppController = ref.watch(menuAppControllerProvider);
//
//     return Scaffold(
//       key: menuAppController.scaffoldKey,
//       appBar: AppBar(
//         title: Image.asset(
//           Constants.logoPath,
//           height: 50,
//         ),
//       ),
//       endDrawer: const SideMenu(),
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (Responsive.isDesktop(context))
//               const Expanded(
//                 child: SideMenu(),
//               ),
//             Expanded(
//               flex: 5,
//               child: Padding(
//                 padding: EdgeInsets.all(AppSpaceSize.mediumSize),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Routemaster.of(context).push('/createUserProfile');
//                   },
//                   child: const Text('프로필 작성'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '홈',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '프로필',
//           ),
//           // 추가적인 탭 아이템을 여기에 추가할 수 있습니다.
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
