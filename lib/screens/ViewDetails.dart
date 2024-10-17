import 'package:flutter/material.dart';

import 'FloorInfoPage.dart';

class ViewDetails extends StatefulWidget {
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  List<bool> _isOpen = [true, false, false];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Leads"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tabs for navigation
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Items",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    // Wrap with GestureDetector
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FloorInfoPage()),
                      );
                    },
                    child: Text("Floor Info"),
                  ),
                  Text("Floor Info"),
                  Text("Send Quote"),
                ],
              ),
            ),
            const Divider(color: Colors.grey),

            // Living Room Section
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text(
                "Living Room",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              children: [
                _buildItem(
                    Icons.chair_alt, "L Type Sofa", "Small | Leather", "1"),
                _buildItem(Icons.chair_alt, "Single Seater Sofa",
                    "Large | Leather", "1"),
                _buildItem(
                    Icons.chair_alt, "Tea Table", "Medium | Wooden", "1"),
                _buildItem(Icons.chair_alt, "Entertainment Unit",
                    "Medium | Wooden", "1"),
                _buildItem(Icons.chair_alt, "Wooden Chairs", "Small", "2"),
                _buildItem(Icons.chair_alt, "Swing", "Large | Wooden", "1"),
                _buildItem(
                    Icons.chair_alt, "Foldable Chairs", "Small | Steel", "4"),
              ],
            ),
            Divider(color: Colors.grey),

            // Bed Room Section
            ExpansionTile(
              title: Text(
                "Bed Room",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              children: [
                _buildItem(Icons.chair_alt, "Bed", "King Size | Wooden", "1"),
                _buildItem(Icons.chair_alt, "Wardrobe", "Large | Wooden", "1"),
              ],
            ),
            Divider(color: Colors.grey),

            // Custom Items Section
            ExpansionTile(
              title: const Text(
                "Custom Items",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              children: [
                _buildCustomItem(
                    "Antique Clock",
                    "200 year old British Period wooden perpetual clock, very unique and rare clock",
                    "L: 6 ft W: 6 ft H: 6 ft"),
                _buildCustomItem(
                    "Antique Clock",
                    "200 year old British Period wooden perpetual clock, very unique and rare clock",
                    "L: 6 ft W: 6 ft H: 6 ft"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build furniture item
  Widget _buildItem(
      IconData iconData, String name, String description, String quantity) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(name),
      subtitle: Text(description),
      trailing: Text(quantity),
    );
  }

  // Helper method to build custom item
  Widget _buildCustomItem(String name, String description, String dimensions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(description),
          const SizedBox(height: 8),
          Text(dimensions, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
  // Helper method to build furniture item
}
