import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies_app/api/api.dart';
import 'package:vacancies_app/edit_profile.dart';
import 'package:vacancies_app/login_screen.dart';
import 'package:vacancies_app/utils/snackbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _getUserInfo();
    fetchProfileData();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  Map<String, dynamic>? profile_data;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
    fetchProfileData();
  }

  fetchProfileData() async {
    // var customer = userData['id'].toString();

    String url = 'get_profile/' + userData['user_id'].toString();
    // if (next != null) {
    //   url = url_format(next);
    // }
    // print(url);
    var res = await CallApi().authenticatedGetRequest(url, context: context);

    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      List<Profile_Item> data = [];
      setState(() {
        profile_data = body;
      });
      // data.add(body[''])
      return body;
    } else {
      showSnack(context, 'No network');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userData == null
                            ? const Text(
                                "",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                userData['username'].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        userData == null
                            ? const Text(
                                "",
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                              )
                            : Text(
                                userData['email'].toString(),
                                style: const TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blueAccent,
                          image: const DecorationImage(
                              image: AssetImage("assets/userx.jpg"),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      // Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfileScreen()));
                    },
                    child: const Text('Update Profile'),
                  ),
                ),
              ),
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fullname',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          userData == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            userData['first_name'].toString() +
                                ' ' +
                                userData['last_name'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          userData == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            userData['email'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['gender'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone Nmuber',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['phone'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              const Text(
                'Proffesional Qualification',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'O-Level Index No',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['o_level_index'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Education',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['education_level'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Program',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['program'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Country',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['country'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              // const Text(
              //   'Language Preferences',
              //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     padding: const EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     child: const Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Fullname',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(
              //               'Firstname Lastname',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Email',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(
              //               'email@example.com',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Gender',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(
              //               'Male',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 15),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Phone Nmuber',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(
              //               '+255786985783',
              //               style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.bold,
              //                   overflow: TextOverflow.ellipsis),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 15),
              //       ],
              //     ),
              //   ),
              // ),
              const Text(
                'Working Experience',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Job Title',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['last_job_title'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Institution',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['institute_name'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Supervisor',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['supervisor_name'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Supervisor Contact',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['supervisor_contact'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['starting_date'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'End Date',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          profile_data == null ?
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          )
                          :
                          Text(
                            profile_data!['end_date'].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Profile_Item {
  final String id,
      last_job_title,
      institute_name,
      supervisor_name,
      supervisor_contact,
      starting_date,
      end_date,
      o_level_index,
      education_level,
      program,
      country,
      date_of_birth,
      gender,
      phone,
      cv;

  Profile_Item(
      this.id,
      this.last_job_title,
      this.institute_name,
      this.supervisor_name,
      this.supervisor_contact,
      this.starting_date,
      this.end_date,
      this.o_level_index,
      this.education_level,
      this.program,
      this.country,
      this.date_of_birth,
      this.gender,
      this.phone,
      this.cv);
}
