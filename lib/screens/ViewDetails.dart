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
      //print("inventory name " + inventory['name']);
      for (final category in inventory['category']) {
        // print("------------Category name=" + category['displayName']);
        for (final items in category['items']) {
          if (items['qty'] > 0) {
            Map<String, dynamic> selectedItem = {
              'productName': inventory['name'],
              'hasSize': false,
              'size': '',
              'hasType': false,
              'type': '',
              "qty": items['qty']
            };

            selectedItem['productName'] = items['displayName'];
            // print("--------------------------------Selected=" +
            //    items['displayName']);

            if (items['meta']['hasSize'] == true) {
              selectedItem['hasSize'] = true;

              for (final options in items['size']) {
                if (options['selected'] == true) {
                  selectedItem['size'] = options['option'];

                  // print(
                  //     "-------------------------------------------------Size=" +
                  //         options['option']);
                  break;
                }
              }
            } else {
              {
                //  print(
                //    "-------------------------------------------------No sizeeeeee");
              }
            }
            if (items['meta']['hasType'] == true) {
              selectedItem['hasType'] = true;

              for (final options in items['type']) {
                if (options['selected'] == true) {
                  //  print(
                  //      "-------------------------------------------------Type=" +
                  //         options['option']);
                  selectedItem['type'] = options['option'];

                  break;
                }
              }
            } else {
              //        print("-------------------------------------------------No type");
            }
            selectedItems.add(selectedItem);
          }
        }
      }
      // print("************************************");
      // if (item['id'] == productId && item['qty'] > 1) {
      //   return true;
      // }
    }

    //customItemDetails['items']['customItems'].toString();
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

      print("***************endddddddddd*********************");
    }
  }

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
                            builder: (context) => FloorInfoPage(FloorInfoDetails:widget.itemDetails)),
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
                Column(
                  children: selectedItems.map((item) {
                    return _buildItem(
                      Icons.chair_alt,
                      item,
                    );
                  }).toList(),
                ),
              ],
            ),
            Divider(color: Colors.grey),

            // Bed Room Section
            const ExpansionTile(
              title: Text(
                "Bed Room",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              children: [
                // _buildItem(
                // Icons.chair_alt,
                //   "Bed",
                //   "King Size | Wooden",
                //   "1",
                // ),
                // _buildItem(
                //   Icons.chair_alt,
                //   "Wardrobe",
                //   "Large | Wooden",
                //   "1",
                // ),
              ],
            ),
            Divider(color: Colors.grey),
            checkInventory(widget.itemDetails),

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
                      return _buildCustomItem(
                        item,
                      );
                    }).toList(),
                  )
                ]),
          ],
        ),
      ),
    );
  }

  // Helper method to build furniture item
  Widget _buildItem(IconData iconData, Map<String, dynamic> selectedItems) {
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
                child: Center(child: Icon(Icons.chair)),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedItems['productName'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    details,
                    style: TextStyle(
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
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // Helper method to build custom item
  Widget _buildCustomItem(Map<String, dynamic> selectedCustomItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(selectedCustomItem['productName'],
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 28)),
          const SizedBox(height: 4),
          Text(selectedCustomItem['description']),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Length: " + selectedCustomItem['length'] + "ft",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Text("Height: " + selectedCustomItem['height'] + "ft",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Text("Width: " + selectedCustomItem['width'] + "ft",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ])
        ],
      ),
    );
  }

  Widget checkInventory(Map<String, dynamic> itemDetails) {
    return Text("test");
  }
  // Helper method to build furniture item
}
