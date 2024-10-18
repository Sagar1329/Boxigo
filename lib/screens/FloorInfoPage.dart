import 'package:flutter/material.dart';

class FloorInfoPage extends StatefulWidget {
  final Map<String, dynamic> FloorInfoDetails;
  const FloorInfoPage({Key? key, required this.FloorInfoDetails})
      : super(key: key);
  @override
  _FloorInfoPageState createState() => _FloorInfoPageState();
}

class _FloorInfoPageState extends State<FloorInfoPage> {
  Map<String, dynamic> floorData = {};

  @override
  void initState() {
    super.initState();
    proccessFloorData(widget.FloorInfoDetails);
  }

  void proccessFloorData(Map<String, dynamic> Data) {
    setState(() {
      floorData = Data;
    });

    print(
        "***********************FLOOR DATA********************************************");
    print(floorData);
    print("Floor number" + floorData["old_floor_no"]);
    print(
        "***********************END FLOOR DATA END********************************************");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Leads'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification actions here
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search actions here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    onTap: () {},
                    child: Text("Floor Info"),
                  ),
                  Text("Floor Info"),
                  Text("Send Quote"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.grey[400],
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Existing house details',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Column(
                    children: [
                      buildDetailRow(
                          "Floor No", floorData["old_floor_no"].toString()),
                      buildDetailRow("Elevator available",
                          floorData["old_elevator_availability"].toString()),
                      buildDetailRow("Packing Required ",
                          floorData["packing_service"].toString()),
                      buildDetailRow("Distance from door to truck",
                          floorData["old_parking_distance"].toString()),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Additonal Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    floorData["old_house_additional_info"] != null &&
                            floorData["old_house_additional_info"] != ""
                        ? floorData["old_house_additional_info"]
                        : "none",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    color: Colors.grey[400],
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'New house details',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  buildDetailRow(
                      "Floor No", floorData["new_floor_no"].toString()),
                  buildDetailRow("Elevator Available",
                      floorData["new_elevator_availability"].toString()),
                  buildDetailRow("Unpacking Required",
                      floorData["unpacking_service"].toString()),
                  buildDetailRow("Distance from door to truck",
                      floorData["new_parking_distance"].toString()),
                  const SizedBox(height: 12.0),
                  Text(
                    'Additonal Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    floorData["new_house_additional_info"] != null &&
                            floorData["new_house_additional_info"] != ""
                        ? floorData["new_house_additional_info"]
                        : "none",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(label, style: TextStyle(fontSize: 16)),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 13.0),
      ],
    );
  }
}
