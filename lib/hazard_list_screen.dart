import 'package:flutter/material.dart';
import 'data.dart';
import 'hazard_form_screen.dart';

class HazardListScreen extends StatefulWidget {
  @override
  State<HazardListScreen> createState() => _HazardListScreenState();
}

class _HazardListScreenState extends State<HazardListScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    // Make a new list that only has the hazards we want to show
    List<Map<String, String>> filteredList = [];
    for (var h in hazards) {
      if (selectedFilter == 'All' || h['status'] == selectedFilter) {
        filteredList.add(h);
      }
    }

    List<String> filterOptions = ['All', 'Open', 'In Progress', 'Resolved'];

    return Column(
      children: [
        // Filter buttons
        SizedBox(
          height: 55,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10),
            children: [
              for (var option in filterOptions)
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(option),
                    selected: selectedFilter == option,
                    onSelected: (value) {
                      setState(() {
                        selectedFilter = option;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),

        // Scrolling list of hazards
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 90),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var hazard = filteredList[index];
              Color severityColor = getSeverityColor(hazard['severity']!);

              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: severityColor, width: 6)),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
                  ],
                ),
                child: InkWell(
                  onTap: () async {
                    // open the edit screen and refresh when we come back
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HazardFormScreen(hazard: hazard),
                      ),
                    );
                    setState(() {});
                  },
                  child: Padding(
                    padding: EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: severityColor, size: 30),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hazard['title']!,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                hazard['location']!,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '${hazard['severity']} severity  |  ${hazard['status']}',
                                style: TextStyle(
                                  color: severityColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
