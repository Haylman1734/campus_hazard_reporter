import 'package:flutter/material.dart';
import 'data.dart';

// This screen is used for both creating and editing.
class HazardFormScreen extends StatefulWidget {
  final Map<String, String>? hazard;

  HazardFormScreen({this.hazard});

  @override
  State<HazardFormScreen> createState() => _HazardFormScreenState();
}

class _HazardFormScreenState extends State<HazardFormScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String selectedCategory = categories[0];
  String selectedSeverity = 'Medium';
  String selectedStatus = 'Open';

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    // If there is a hazard, fill the form with its details
    if (widget.hazard != null) {
      isEditing = true;
      titleController.text = widget.hazard!['title']!;
      locationController.text = widget.hazard!['location']!;
      descriptionController.text = widget.hazard!['description']!;
      selectedCategory = widget.hazard!['category']!;
      selectedSeverity = widget.hazard!['severity']!;
      selectedStatus = widget.hazard!['status']!;
    }
  }

  void saveHazard() {
    if (formKey.currentState!.validate()) {
      if (isEditing) {
        // update the existing hazard
        widget.hazard!['title'] = titleController.text;
        widget.hazard!['location'] = locationController.text;
        widget.hazard!['description'] = descriptionController.text;
        widget.hazard!['category'] = selectedCategory;
        widget.hazard!['severity'] = selectedSeverity;
        widget.hazard!['status'] = selectedStatus;
      } else {
        // add a new hazard to the top of the list
        hazards.insert(0, {
          'title': titleController.text,
          'location': locationController.text,
          'description': descriptionController.text,
          'category': selectedCategory,
          'severity': selectedSeverity,
          'status': 'Open',
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEditing ? 'Report updated' : 'Hazard reported. Thank you!')),
      );
      Navigator.pop(context);
    }
  }

  void deleteHazard() {
    hazards.remove(widget.hazard);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Report' : 'Report a Hazard'),
        actions: [
          if (isEditing)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteHazard,
            ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Hazard Title',
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'Title must be at least 5 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Location (e.g. Block A, Level 2)',
                      prefixIcon: Icon(Icons.place),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category),
                    ),
                    items: categories.map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedSeverity,
                    decoration: InputDecoration(
                      labelText: 'Severity',
                      prefixIcon: Icon(Icons.priority_high),
                    ),
                    items: severities.map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSeverity = value!;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.length < 10) {
                        return 'Please describe the hazard (at least 10 characters)';
                      }
                      return null;
                    },
                  ),

                  // Status can only be changed when editing
                  if (isEditing) ...[
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        prefixIcon: Icon(Icons.flag),
                      ),
                      items: statuses.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                    ),
                  ],

                  SizedBox(height: 15),
                  // Photo box
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Photo upload coming')),
                      );
                    },
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: mainColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, color: mainColor),
                          Text('Add Photo (optional)'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: saveHazard,
                    child: Text(isEditing ? 'Save Changes' : 'Submit Report'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
