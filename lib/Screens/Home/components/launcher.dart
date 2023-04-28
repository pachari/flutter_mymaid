import 'package:flutter/material.dart';
import '../../../constants.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../home.dart';
import '../../Checkin/my_checkin.dart';
import '../../Calendar/my_calendar.dart';
import '../../Setting/my_setting.dart';
import '../../Checkin/checklist.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';
  late  int currentPage;
   Launcher(this.currentPage, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const Home(),
    const Mycheck(),
    const GetChecklist(),
    const CalendarScreen(),
    const Settings(),
  ];

  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.house),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.listCheck),
      label: 'Check List',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.listCheck),
      label: 'List',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.clockRotateLeft),
      label: 'History',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.gear),
      label: 'Settings',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentPage == 9999) {
      _selectedIndex = 2;
      widget.currentPage = 0;
    } 
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kselectedItemColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
