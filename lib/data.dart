import 'package:flutter/material.dart';

// Main colour used across the whole app
Color mainColor = Colors.redAccent;

// Hard-coded data
List<Map<String, String>> hazards = [
  {
    'title': 'Wet floor near The Hub',
    'location': 'The Hub',
    'category': 'Slippery Floor',
    'severity': 'High',
    'status': 'Open',
    'description': 'Water is leaking from the roof and the floor is slippery.',
  },
  {
    'title': 'Broken streetlight',
    'location': 'Parking Lot',
    'category': 'Lighting',
    'severity': 'Medium',
    'status': 'In Progress',
    'description': 'The light has not worked for a week. The path is dark at night.',
  },
  {
    'title': 'Exposed wiring',
    'location': 'Science Tower Lab',
    'category': 'Electrical',
    'severity': 'High',
    'status': 'Open',
    'description': 'Wires are hanging out of the wall socket.',
  },
  {
    'title': 'Loose stair railing',
    'location': 'Library Stairs',
    'category': 'Broken Facility',
    'severity': 'Low',
    'status': 'Resolved',
    'description': 'The railing on the second floor staircase is loose.',
  },
  {
    'title': 'Blocked fire exit',
    'location': 'Academic Tower',
    'category': 'Fire Risk',
    'severity': 'Medium',
    'status': 'Open',
    'description': 'Chairs are stacked in front of the emergency exit.',
  },
];

List<String> categories = [
  'Broken Facility',
  'Slippery Floor',
  'Fire Risk',
  'Electrical',
  'Flooding',
  'Lighting',
  'Other',
];

List<String> severities = ['Low', 'Medium', 'High'];
List<String> statuses = ['Open', 'In Progress', 'Resolved'];

// Returns a colour depending on how serious the hazard is
Color getSeverityColor(String severity) {
  if (severity == 'High') {
    return Colors.red;
  } else if (severity == 'Medium') {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}

// Counts how many hazards have a certain status
int countStatus(String status) {
  int count = 0;
  for (var h in hazards) {
    if (h['status'] == status) {
      count++;
    }
  }
  return count;
}
