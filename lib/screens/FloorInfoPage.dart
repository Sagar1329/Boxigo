import 'package:flutter/material.dart';

class FloorInfoPage extends StatefulWidget {
  @override
  _FloorInfoPageState createState() => _FloorInfoPageState();
}

class _FloorInfoPageState extends State<FloorInfoPage> {
  final List<FloorDetail> _floorDetails = [
    FloorDetail(label: 'Floor No.', value: '10'),
    FloorDetail(label: 'Elevator Available', value: 'Yes'),
    FloorDetail(label: 'Packing Required', value: 'Yes'),
    FloorDetail(label: 'Distance from door to truck', value: '20 mtrs'),
  ];

  final List<FloorDetail> _newHouseDetails = [
    FloorDetail(label: 'Floor No.', value: '0'),
    FloorDetail(label: 'Elevator Available', value: 'No'),
    FloorDetail(label: 'Unpacking Required', value: 'Yes'),
    FloorDetail(label: 'Distance from door to truck', value: '50 mtrs'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor Info Page'),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Existing house details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15.0),
                  ..._floorDetails
                      .map((detail) =>
                          buildDetailRow(detail.label, detail.value))
                      .toList(),
                  const SizedBox(height: 12.0),
                  Text(
                    'Additonal Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Dog idde',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'New house details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15.0),
                  ..._newHouseDetails
                      .map((detail) =>
                          buildDetailRow(detail.label, detail.value))
                      .toList(),
                  const SizedBox(height: 12.0),
                  Text(
                    'Additonal Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Dog idde',
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

class FloorDetail {
  final String label;
  final String value;

  FloorDetail({required this.label, required this.value});
}
