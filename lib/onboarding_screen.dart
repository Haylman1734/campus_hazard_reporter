import 'package:flutter/material.dart';
import 'data.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int currentPage = 0;

  // The content of the 3 intro pages
  List<Map<String, dynamic>> pages = [
    {
      'icon': Icons.report_problem,
      'title': 'Spot a Hazard?',
      'text': 'Report broken facilities, slippery floors or unsafe areas around campus.',
    },
    {
      'icon': Icons.edit_note,
      'title': 'Describe It',
      'text': 'Add the location, category and severity so it can be fixed quickly.',
    },
    {
      'icon': Icons.verified_user,
      'title': 'Track Progress',
      'text': 'See if your report is Open, In Progress or Resolved.',
    },
  ];

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: goToLogin,
                child: Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container with BoxDecoration
                        Container(
                          padding: EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: mainColor, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(pages[index]['icon'], size: 80, color: mainColor),
                        ),
                        SizedBox(height: 40),
                        Text(
                          pages[index]['title'],
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          pages[index]['text'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage == pages.length - 1) {
                    goToLogin();
                  } else {
                    controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Text(currentPage == pages.length - 1 ? 'Get Started' : 'Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
