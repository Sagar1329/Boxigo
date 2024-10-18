// widgets/app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMainPage; // New parameter to determine if it's the main page

  const CustomAppBar({
    Key? key,
    required this.title,
    this.isMainPage = false, // Default to false for other pages
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          isMainPage
              ? Icon(Icons.home) // Show home icon on main page
              : SizedBox(),
          SizedBox(width: 8),
          Text(title),
          Spacer(),
          Icon(Icons.notifications),
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.red,
            child: Text(
              '99+',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.search),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
