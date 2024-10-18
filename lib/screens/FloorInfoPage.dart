import 'package:boxigo_app/screens/ViewDetails.dart';
import 'package:boxigo_app/widgets/TabWidget.dart';
import 'package:boxigo_app/widgets/app_bar.dart';
import 'package:boxigo_app/widgets/bottom_navigation.dart';
import 'package:boxigo_app/widgets/detail_row_widget.dart';
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
  int selectedIndex = 1;
  @override
  void initState() {
    super.initState();
    proccessFloorData(widget.FloorInfoDetails);
  }

  void proccessFloorData(Map<String, dynamic> Data) {
    setState(() {
      floorData = Data;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onTabTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewDetails(itemDetails: floorData),
          ),
        );
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: "New Leads"),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      DetailRowWidget(
                          label: "Floor No",
                          value: floorData["old_floor_no"].toString()),
                      DetailRowWidget(
                          label: "Elevator available",
                          value: floorData["old_elevator_availability"]
                              .toString()),
                      DetailRowWidget(
                          label: "Packing Required ",
                          value: floorData["packing_service"].toString()),
                      DetailRowWidget(
                          label: "Distance from door to truck",
                          value: floorData["old_parking_distance"].toString()),
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
                  DetailRowWidget(
                      label: "Floor No",
                      value: floorData["new_floor_no"].toString()),
                  DetailRowWidget(
                      label: "Elevator Available",
                      value: floorData["new_elevator_availability"].toString()),
                  DetailRowWidget(
                      label: "Unpacking Required",
                      value: floorData["unpacking_service"].toString()),
                  DetailRowWidget(
                      label: "Distance from door to truck",
                      value: floorData["new_parking_distance"].toString()),
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
