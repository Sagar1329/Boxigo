import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/ViewDetails.dart';

class LeadCardWidget extends StatelessWidget {
  final dynamic leadData;

  const LeadCardWidget({Key? key, required this.leadData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movingOnData = DateTime.parse(leadData['moving_on']);
    final monthString = DateFormat('MMM').format(movingOnData);
    final dateString = movingOnData.day.toString();
    final timeString = DateFormat('HH:mm').format(movingOnData);

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
                            leadData["from_address"]["fromCity"].toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            leadData['estimate_id'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Text(leadData['moving_from'].toString(),
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
                  height: 44.0,
                  color: Colors.orange,
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconDetail(Icons.home, leadData['property_size']),
                  SizedBox(width: 20),
                  _buildIconDetail(
                      Icons.inbox, "${leadData["total_items"]} items"),
                  SizedBox(width: 20),
                  _buildIconDetail(Icons.local_shipping, "20 boxes"),

                  /*
          COULD NOT FIND BOXES DATA IN API , HENCE USED THE A DEFAULT VALUE
                   */
                  SizedBox(width: 20),
                  _buildIconDetail(Icons.location_on, leadData["distance"]),
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
                      Text(
                        leadData["to_address"]["toCity"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(leadData["moving_to"],
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15), // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    // Handle "View Details" click
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewDetails(itemDetails: leadData),
                      ),
                    );
                  },
                  child: Text("View Details",
                      style: TextStyle(color: Colors.orange)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle "Submit Quote" click
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 242, 42, 42),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
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

  Widget _buildIconDetail(IconData icon, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.orange),
        Text(text, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
