import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'screens/ViewDetails.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(BoxigoApp());
}

class BoxigoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boxigo App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  Map<String, dynamic>? _fetchedData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1; // Default to "New" tab
  Map<String, dynamic>? _fetchedData;
  List<dynamic>? customerEstimateFlow; // Declare here
  List<dynamic>? ItemDetails;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://test.api.boxigo.in/sample-data/'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _fetchedData = data;
          customerEstimateFlow = data['Customer_Estimate_Flow']        as List<dynamic>; 
     });
        print("********************************************************");
        print(data);

        print("2---------" + data["Customer_Estimate_Flow"].toString());

        for (int i = 0; i < customerEstimateFlow!.length; i++) {
          print("3---------" +
              data["Customer_Estimate_Flow"][i]["estimate_id"].toString());
        }

        print("3---------" +
            data["Customer_Estimate_Flow"][0]["estimate_id"].toString());

        print("********************************************************");
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home),
            SizedBox(width: 8),
            Text("Leads"),
            Spacer(),
            Icon(Icons.notifications),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Text('99+',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
            SizedBox(width: 8),
            Icon(Icons.search),
          ],
        ),
      ),
      body: Column(
        children: [
          // Tab bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTab("All", 0),
                _buildTab("New", 1),
                _buildTab("Follow Up", 2),
                _buildTab("Booked", 3),
                _buildTab("In Transit", 4),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: customerEstimateFlow!.length,
              itemBuilder: (context, index) {
                return _buildLeadCard(index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Select "Leads" tab
        onTap: (index) {
          // Handle bottom nav tap
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Colors.black),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Leads"),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More"),
        ],
      ),
    );
  }

  // Tab item builder
  Widget _buildTab(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: selectedIndex == index ? Colors.orange : Colors.black,
            fontWeight:
                selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Lead card builder
  Widget _buildLeadCard(dynamic index) {
    final movingOnData =
        DateTime.parse(customerEstimateFlow![index]['moving_on']);
    final monthString = DateFormat('MMM').format(movingOnData);

    // Get date (e.g., 23)
    final dateString = movingOnData.day.toString();

    // Get time (e.g., 23:45)
    final timeString = DateFormat('HH:mm').format(movingOnData);

    final timeString2 = DateFormat('hh:mm a').format(movingOnData);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Time
            Row(
              children: [
                Column(
                  children: [
                    Text(monthString,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(dateString,
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    Text(timeString, style: TextStyle(color: Colors.black)),
                    //If want to show time in 12 hours format
                    //   Text(timeString2, style: TextStyle(color: Colors.black)),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                customerEstimateFlow![index]["from_address"]
                                        ["fromCity"]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(customerEstimateFlow![index]['estimate_id'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ]),
                      Text(
                          customerEstimateFlow![index]['moving_from']
                              .toString(),
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(children: [
                Image.asset(
                  'assets/images/down_arrow.png',
                  width: 44.0,
                  height: 44.0, // Initial height, will be scaled
                  color: Colors.orange, // Optional: apply a color filter
                  // Maintains aspect ratio while scaling
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.home, color: Colors.orange),
                      Text(customerEstimateFlow![index]['property_size'],
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.inbox, color: Colors.orange),
                      Text(
                          customerEstimateFlow![index]["total_items"] +
                              " items",
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.local_shipping, color: Colors.orange),
                      Text("20 boxes", style: TextStyle(fontSize: 15)),
                      //Note: Could not find the boxed count in the api response
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Colors.orange),
                      Text(customerEstimateFlow![index]["distance"],
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ]),
            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40),
                // Location and Reference Number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customerEstimateFlow![index]["to_address"]["toCity"],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(customerEstimateFlow![index]["moving_to"],
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            // House Info

            SizedBox(height: 15), // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius
                          .zero, // Set border radius to zero for rectangular shape
                    )),
                    onPressed: () {
                      // Handle "View Details" click
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewDetails(itemDetails: customerEstimateFlow![index])),
                      );
                    },
                    child: Text("View Details",
                        style: TextStyle(color: Colors.orange))),
                ElevatedButton(
                  onPressed: () {
                    // Handle "Submit Quote" click
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 242, 42, 42),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius
                            .zero, // Set border radius to zero for rectangular shape
                      )),
                  child: Text("Submit Quote",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
