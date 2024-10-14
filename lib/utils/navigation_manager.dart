// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:hive/hive.dart';
// import '../views/favourites_screen.dart';
// import '../views/home_screen.dart';
// import '../widgets/settings_modal.dart';
// import '../theme/app_colors.dart';

// class NavigationManager extends StatefulWidget {
//   const NavigationManager({super.key});

//   @override
//   _NavigationManagerState createState() => _NavigationManagerState();
// }

// class _NavigationManagerState extends State<NavigationManager> {
//   int _selectedIndex = 0;
//   final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
//   var favouritesBox = Hive.box('favouritesBox');

//   static const List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     FavouritesScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     FlutterNativeSplash.remove();
//   }

//   void _refreshFavourites() {
//     setState(() {
//       favouritesBox = Hive.box('favouritesBox');
//     });
//   }

//   void _onItemTapped(int index) {
//     if (index == 2) {
//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return SizedBox(
//             height: MediaQuery.of(context).size.height / 2.5,
//             child: SettingsScreen(
//               onFavouritesCleared: _refreshFavourites,
//             ),
//           );
//         },
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(32),
//           ),
//         ),
//         backgroundColor: AppColors.cardColor,
//       );
//     } else {
//       setState(() {
//         _selectedIndex = index;
//         _navigatorKey.currentState?.pushReplacement(
//           PageRouteBuilder(
//             pageBuilder: (context, animation, secondaryAnimation) =>
//                 _widgetOptions[index],
//             transitionDuration: Duration.zero,
//             reverseTransitionDuration: Duration.zero,
//           ),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         title: Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Image.asset(
//             'assets/images/logo.png',
//             width: 120,
//             height: 120,
//             fit: BoxFit.contain,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Navigator(
//         key: _navigatorKey,
//         onGenerateRoute: (routeSettings) {
//           return MaterialPageRoute(
//             builder: (context) => Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: _widgetOptions[_selectedIndex],
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 0),
//           child: SizedBox(
//             height: 110,
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               backgroundColor: AppColors.backgroundColor,
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.favorite),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.settings),
//                   label: '',
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//               iconSize: 28,
//               selectedIconTheme: const IconThemeData(size: 35),
//               showUnselectedLabels: false,
//               showSelectedLabels: false,
//               enableFeedback: true,
//               selectedItemColor: AppColors.primary,
//               unselectedItemColor: AppColors.unselectedColor,
//               onTap: _onItemTapped,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
