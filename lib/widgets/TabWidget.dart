// widgets/TabWidget.dart
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final String label;        
  final int index;          
  final int selectedIndex;  
  final Function(int) onTap; 

  const TabWidget({
    Key? key,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),  
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: selectedIndex == index ? Colors.orange : Colors.black,
            fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
