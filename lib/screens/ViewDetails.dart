import 'package:boxigo_app/widgets/TabWidget.dart';
import 'package:boxigo_app/widgets/app_bar.dart';
import 'package:boxigo_app/widgets/bottom_navigation.dart';
import 'package:boxigo_app/widgets/custom_item_widget.dart';
import 'package:boxigo_app/widgets/item_widget.dart';
import 'package:flutter/material.dart';

import 'FloorInfoPage.dart';

class ViewDetails extends StatefulWidget {
  final Map<String, dynamic> itemDetails;
  const ViewDetails({Key? key, required this.itemDetails}) : super(key: key);

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  List<bool> _isOpen = [true, false, false];
  int selectedIndex = 0;

  List<Map<String, dynamic>> selectedItems = [];
  List<Map<String, dynamic>> selectedCustomItems = [];
  Map<String, dynamic> customItemDetails = {};
  @override
  void initState() {
    super.initState();
    processInventory(widget.itemDetails);
    processCustomInventory(widget.itemDetails);
  }

  void processInventory(Map<String, dynamic> itemDetails) {
    for (final inventory in itemDetails['items']['inventory']) {
      for (final category in inventory['category']) {
        for (final items in category['items']) {
          if (items['qty'] > 0) {
            Map<String, dynamic> selectedItem = {
              'productName': items['displayName'],
              'hasSize': false,
              'size': '',
              'hasType': false,
              'type': '',
              "qty": items['qty']
            };
            if (items['meta']['hasSize'] == true) {
              selectedItem['hasSize'] = true;

              for (final options in items['size']) {
                if (options['selected'] == true) {
                  selectedItem['size'] = options['option'];
                  break;
                }
              }
            }
            if (items['meta']['hasType'] == true) {
              selectedItem['hasType'] = true;

              for (final options in items['type']) {
                if (options['selected'] == true) {
                  selectedItem['type'] = options['option'];

                  break;
                }
              }
            } else {}
            selectedItems.add(selectedItem);
          }
        }
      }
    }
  }

  void processCustomInventory(Map<String, dynamic> itemDetails) {
    for (final customItem in itemDetails['items']['customItems']['items']) {
      Map<String, dynamic> selectedCustomItem = {
        'productName': customItem['item_name'],
        'length': customItem['item_length'],
        'height': customItem['item_height'],
        'width': customItem['item_width'],
        'description': customItem['item_description'],
        "qty": customItem['item_qty']
      };
      selectedCustomItems.add(selectedCustomItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    void _onTabTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FloorInfoPage(FloorInfoDetails: widget.itemDetails)),
        );
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: "New Leads"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tabs for navigation
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TabWidget(
                    label: "Items",
                    index: 0,
                    selectedIndex: selectedIndex,
                    onTap: _onTabTapped,
                  ),
                  TabWidget(
                    label: "Floor info",
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: _onTabTapped,
                  ),
                  TabWidget(
                    label: "Send Quote",
                    index: 2,
                    selectedIndex: selectedIndex,
                    onTap: _onTabTapped,
                  ),
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
                Column(
                  children: selectedItems.map((item) {
                    return ItemWidget(
                      iconData: Icons.chair_alt,
                      selectedItems: item,
                    );
                  }).toList(),
                ),
              ],
            ),
            Divider(color: Colors.grey),

            const ExpansionTile(
              title: Text(
                "Bed Room",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              children: [],
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
                  Column(
                    children: selectedCustomItems.map((item) {
                      return CustomItemWidget(
                        selectedCustomItem: item,
                      );
                    }).toList(),
                  )
                ]),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
