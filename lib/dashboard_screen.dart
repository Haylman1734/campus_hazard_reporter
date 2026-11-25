import 'package:flutter/material.dart';
import 'data.dart';
import 'hazard_list_screen.dart';
import 'hazard_form_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  // Home tab: summary + recent reports
  Widget buildHomeTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Welcome banner
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Student!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Help keep our campus safe. See something? Report it.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Summary cards
        Row(
          children: [
            Expanded(child: buildStatCard('Total', hazards.length, Colors.blueGrey)),
            SizedBox(width: 8),
            Expanded(child: buildStatCard('Open', countStatus('Open'), Colors.red)),
            SizedBox(width: 8),
            Expanded(child: buildStatCard('Resolved', countStatus('Resolved'), Colors.green)),
          ],
        ),
        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Reports',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Text('See all'),
            ),
          ],
        ),

        // Show only the first 3 hazards
        for (int i = 0; i < hazards.length && i < 3; i++)
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ListTile(
              leading: Icon(
                Icons.warning,
                color: getSeverityColor(hazards[i]['severity']!),
              ),
              title: Text(hazards[i]['title']!),
              subtitle: Text(hazards[i]['location']!),
              trailing: Text(hazards[i]['status']!),
            ),
          ),
      ],
    );
  }

  Widget buildStatCard(String label, int number, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(top: BorderSide(color: color, width: 4)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Text(
            '$number',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
          ),
          Text(label),
        ],
      ),
    );
  }

  // Profile tab
  Widget buildProfileTab() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: mainColor,
            child: Icon(Icons.person, size: 55, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Student User',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text('student@campus.edu'),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(150, 45)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text('Log Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentTab;
    if (selectedIndex == 0) {
      currentTab = buildHomeTab();
    } else if (selectedIndex == 1) {
      currentTab = HazardListScreen();
    } else {
      currentTab = buildProfileTab();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Campus Hazard Reporter')),
      body: currentTab,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text('Report'),
        onPressed: () async {
          // wait until the form screen is closed, then refresh this screen
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HazardFormScreen()),
          );
          setState(() {});
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: mainColor,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
