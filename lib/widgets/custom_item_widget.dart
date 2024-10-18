import 'package:flutter/material.dart';

class CustomItemWidget extends StatelessWidget {
  final Map<String, dynamic> selectedCustomItem;

  const CustomItemWidget({
    Key? key,
    required this.selectedCustomItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(selectedCustomItem['productName'],
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
          const SizedBox(height: 4),
          Text(selectedCustomItem['description']),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Length: " + selectedCustomItem['length'] + "ft",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            Text("Height: " + selectedCustomItem['height'] + "ft",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            Text("Width: " + selectedCustomItem['width'] + "ft",
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ]),
        ],
      ),
    );
  }
}
