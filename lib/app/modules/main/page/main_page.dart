import 'package:flutter/material.dart';

import '../../features/dashboard/home/page/home_page.dart';
import '../../features/inspection/form/page/inspection_form_page.dart';
import '../../features/profile/account/page/profile_page.dart';
import '../../features/vehicle/history/page/vehicle_history_page.dart';
import '../widget/main_bottom_navigation.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  final List<Widget> _pages = const <Widget>[
    HomePage(),
    InspectionFormPage(showBackButton: false),
    VehicleHistoryPage(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: MainBottomNavigation(
        currentIndex: _index,
        onTap: _onTap,
      ),
    );
  }
}
