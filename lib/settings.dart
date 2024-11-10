import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_waste/home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? phoneNumber;
  String? selectedValue;
  @override
  void initState() {
    super.initState();
  }

  var responseData;
  String? phonenumber_pat;

  // Future<void> fetchDetails() async {
  //   String? phoneNumber = await getPhoneNumber();
  //   var url = Uri.parse(
  //       '${Api.url}/HandleNurse?type=no-auth&phone_number=${phoneNumber.toString()}');
  //   var response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     print('Details fetched successfully');
  //     print(response.body);
  //     responseData = jsonDecode(response.body);
  //     setState(() {});
  //     // responseData = jsonDecode(response.body);
  //     print(responseData['content']['phone_number']);
  //   } else {
  //     print('Failed to fetch details');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Header with account info
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(203, 100, 235, 33),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'pradeep',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    phonenumber_pat ?? 'No phone number',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            _buildListTile('Change Password', Icons.lock, () {}),
            Card(
              elevation: 5,
              shadowColor: const Color.fromARGB(203, 100, 235, 33),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(
                  'Change language',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Icon(Icons.language, color: Colors.black),
                onTap: () async {
                  bool? confirm_lang_change = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Choose language',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        content: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedValue,
                          hint: Text('Select an option'),
                          items: <String>[
                            'English',
                            'Tamil',
                            'Hindi',
                            'Spanish'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            const Map<String, String> languageCodes = {
                              'English': 'en',
                              'Tamil': 'ta',
                              'Hindi': 'hi',
                              'Spanish': 'es',
                            };

                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Language changed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  content: Text(
                                    'The language has been changed to $selectedValue please restart the app to apply the changes',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        SystemNavigator.pop();
                                      },
                                      child: Text('Restart App'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            _buildListTile(
              'About',
              Icons.info,
              () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Placeholder();
                }));
              },
            ),
            _buildListTile('Log out', Icons.exit_to_app, () async {
              bool? confirmLogout = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Confirm log out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to logout?',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (Route<dynamic> route) =>
                                false, // Clears all previous routes
                          );
                        },
                        child: Text('Log out'),
                      ),
                    ],
                  );
                },
              );

              if (confirmLogout == true) {
                // Perform log out
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 5,
      shadowColor: const Color.fromARGB(203, 100, 235, 33),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Icon(icon, color: Colors.amber),
        onTap: onTap,
      ),
    );
  }
}
