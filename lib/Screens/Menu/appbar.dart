import 'package:flutter/material.dart';
import '../../constants.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppBar( {super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Check List'),
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor, //kTabsColor,
        bottom: TabBar(
          indicatorColor: const Color.fromARGB(255, 255, 255, 255),
          tabs: choices.map((Choice choice) {
            // print(_page);
            // print(DefaultTabController.of(context).index);

            return Tab(
              text: choice.title,
              icon: Icon(choice.icon, size: 30),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class Choice {
  const Choice(
      {required this.title,
      required this.icon,
      required this.page,
      required this.id});

  final String title;
  final IconData icon;
  final int page;
  final int id;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'All', icon: Icons.radio_button_checked_sharp, page: 4, id: 0),
  Choice(title: 'Pending', icon: Icons.circle_outlined, page: 3, id: 1),
  Choice(title: 'Visiting', icon: Icons.play_circle_outline, page: 2, id: 2),
  Choice(title: 'Done', icon: Icons.check_circle_outline_rounded, page: 1, id: 3),
];
