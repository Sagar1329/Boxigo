import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final IconData iconData;
  final Map<String, dynamic> selectedItems;

  const ItemWidget({
    Key? key,
    required this.iconData,
    required this.selectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String details = '';

    if ((selectedItems['hasSize'] == true) &&
        (selectedItems["hasType"] == true)) {
      details = selectedItems['size'] + "|" + selectedItems['type'];
    } else if (selectedItems['hasSize'] == true) {
      details = selectedItems['size'];
    } else if (selectedItems['hasType'] == true) {
      details = selectedItems['type'];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  // Adjust color as needed
                ),
                child:
                    Center(child: Icon(iconData)), // Use the iconData parameter
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedItems['productName'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    details,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Text(
            selectedItems['qty'].toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
