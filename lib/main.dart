import 'dart:convert';
import 'package:boxigo_app/widgets/LeadCardWidget.dart';
import 'package:boxigo_app/widgets/TabWidget.dart';
import 'package:boxigo_app/widgets/app_bar.dart';
import 'package:boxigo_app/widgets/bottom_navigation.dart';
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
        debugShowCheckedModeBanner: false,
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
  int selectedIndex = 1;
  Map<String, dynamic>? _fetchedData;
  List<dynamic>? customerEstimateFlow;
  bool _isLoading = true;
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
          customerEstimateFlow =
              data['Customer_Estimate_Flow'] as List<dynamic>;
          _isLoading = false;
        });
        /* print("********************************************************");
         print(data);

   print("2---------" + data["Customer_Estimate_Flow"].toString());

         for (int i = 0; i < customerEstimateFlow!.length; i++) {
           print("3---------" +
  data[
                       "Customer_Estimate_Flow"][i]["estimate_id"]
                   .toString());
         }

         print("3---------" +
             data["Customer_Estimate_Flow"][0]["estimate_id"].toString());

         print("********************************************************");
        */
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    void _onTabTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Leads", isMainPage: true),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TabWidget(
                        label: "All",
                        index: 0,
                        selectedIndex: selectedIndex,
                        onTap: _onTabTapped,
                      ),
                      TabWidget(
                        label: "New",
                        index: 1,
                        selectedIndex: selectedIndex,
                        onTap: _onTabTapped,
                      ),
                      TabWidget(
                        label: "Follow Up",
                        index: 2,
                        selectedIndex: selectedIndex,
                        onTap: _onTabTapped,
                      ),
                      TabWidget(
                        label: "Booked",
                        index: 3,
                        selectedIndex: selectedIndex,
                        onTap: _onTabTapped,
                      ),
                      TabWidget(
                        label: "In Transit",
                        index: 4,
                        selectedIndex: selectedIndex,
                        onTap: _onTabTapped,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: customerEstimateFlow!.length,
                    itemBuilder: (context, index) {
                      return LeadCardWidget(
                          leadData: customerEstimateFlow![index]);
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
