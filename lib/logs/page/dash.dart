import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
      ),
      body: ListView(
        children: <Widget>[
          DashboardItem(title: 'Chat', icon: Icons.chat),
          DashboardItem(title: 'Church Branches', icon: Icons.location_city),
          DashboardItem(title: 'Groups', icon: Icons.group),
          DashboardItem(title: 'Events', icon: Icons.event),
          DashboardItem(title: 'Sermons', icon: Icons.book),
          DashboardItem(title: 'Account', icon: Icons.account_circle),
          // Add more items here
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const DashboardItem({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Handle item tap
      },
    );
  }
}
