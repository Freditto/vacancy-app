import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies_app/api/api.dart';
import 'package:vacancies_app/aptitude_test.dart';
import 'package:vacancies_app/components/appbar.dart';
import 'package:vacancies_app/components/constants.dart';
import 'package:vacancies_app/components/icon_text.dart';
import 'package:vacancies_app/job_details.dart';
import 'package:vacancies_app/job_item.dart';
import 'package:vacancies_app/login_screen.dart';
import 'package:vacancies_app/personal_cv.dart';
import 'package:vacancies_app/profile.dart';
import 'package:vacancies_app/utils/commons.dart';
import 'package:vacancies_app/utils/snackbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData, next;

  List<Job_Item>? job_data;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _getUserInfo();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
    fetchJobData();
  }

  fetchJobData() async {
    // var customer = userData['id'].toString();
    String url = 'api/getVacancies';
    // if (next != null) {
    //   url = url_format(next);
    // }
    var res = await CallApi().authenticatedGetRequest(url, context: context);

    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      var jobItensJson = body;
      List<Job_Item> _job_items = [];
      if (next != null) {
        _job_items = job_data!;
      }

      for (var f in jobItensJson) {
        Job_Item job_items = Job_Item(
          f['id'].toString(),
          f['company'].toString(),
          f['jobTitle'].toString(),
          f['jobType'].toString(),
          f['requirements'],
        );
        _job_items.add(job_items);
      }
      print(_job_items.length);
      // setState(() {
      //   loading = false;
      // });

      setState(() {
        job_data = _job_items;
       
      });
    } else {
      showSnack(context, 'No network');
      return [];
    }
  }

  _changePassword_Dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change password'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Password',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      // controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // maxLines: widget.maxLines,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'New Password',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      // controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // maxLines: widget.maxLines,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            // _deleteSingleProductTocart(index);
                            // logOUT_User();
                            Navigator.of(context).pop();

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginScreen()));
                          },
                          child: Text('Change')),

                      SizedBox(
                        width: 30,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel')),
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // }
                    ])
              ],
            ),
          );
        });
  }

  _logoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Logout'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    "Are you sure you want to logout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            // _deleteSingleProductTocart(index);
                            // logOUT_User();
                            Navigator.of(context).pop();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text('Yes')),

                      SizedBox(
                        width: 30,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('No')),
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // }
                    ])
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  // color: Colors.blue,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    minRadius: 40.0,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage("assets/user1.jpg"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Leonardo Palmeiro',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.edit,
              ),
              title: const Text('My Applications'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  
                });
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_outlined,
              ),
              title: const Text('Register to Job Alert'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.lock_outline,
              ),
              title: const Text('Change password'),
              onTap: () {
                Navigator.pop(context);
                _changePassword_Dialog(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback_outlined,
              ),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);

                _logoutDialog(context);
              },
            ),
          ],
        ),
      ),

      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70), child: CustomAppBar()),

      // body: Column(

      //   children: [

      //     jobList(),
      //   ],
      // ),

      body: Column(
        children: [
          Expanded(child: jobComponent()),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Personal_CV_Screen()));
        },
        label: const Text('Set or Update CV'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: kDarkGreenColor,
      ),
    );
  }

  jobComponent() {
    if (job_data == null) {
      return Center(
        child: Text('No Data...'),
      );
    } else if (job_data != null && job_data?.length == 0) {
      // No Data
      return Center(
        child: Text('No Data or No jobs yet...'),
      );
    } else {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: job_data!.length,
          //itemCount: ProductModel.items.length,
          itemBuilder: (BuildContext context, int index) {
            // print("iMAGE");
            // print(job_data![index].product_image);

            return Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                height: 160,
                child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            padding: EdgeInsets.all(25),
                            height: 550,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30.0),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 60,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                                child: Image.asset(
                                                    'assets/apply.png'),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                job_data![index].company,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // widget.job.isMark = !widget.job.isMark;
                                                    // if(selected = true)
                                                    //   selected=false;
                                                  });
                                                },
                                                child: Container(
                                                  child: Icon(Icons
                                                      .bookmark_outline_sharp),
                                                ),
                                              ),
                                              Icon(Icons.more_horiz_outlined),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        job_data![index].jobTitle,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconText(
                                            icon: Icons.location_on_outlined,
                                            text: 'Location',
                                          ),
                                          IconText(
                                            icon: Icons.access_time_outlined,
                                            text: job_data![index].jobType,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Requirements',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ...job_data![index]
                                          .requirements!
                                          .map(
                                            (e) => Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 10, 10, 0),
                                                    width: 5,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.black),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 400),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      e!['requirement'],
                                                      style: TextStyle(
                                                          wordSpacing: 2.5,
                                                          height: 1.5),
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 25),
                                        height: 45,
                                        width: double.maxFinite,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              primary: kDarkGreenColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          onPressed: () {
                                            Navigator.pop(context);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AptitudeTestScreen(job_data![index].id, job_data![index].company,)));
                                          },
                                          child: Text('Apply Now'),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
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
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: Image.asset('assets/apply.png'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      job_data![index].company,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // widget.job.isMark = !widget.job.isMark;
                                      // if(selected = true)
                                      //   selected=false;
                                    });
                                  },
                                  child: Container(
                                      child:
                                          Icon(Icons.bookmark_outline_sharp)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              job_data![index].jobTitle,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(height: 15),
                            IconText(
                              icon: Icons.access_time_outlined,
                              text: job_data![index].jobType,
                            ),
                          ],
                        ),
                      ),
                    )));
          });
    }
  }
}

//   Widget jobList() {
//     final jobList = Job.generateJobs();

//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 25),
//       height: 160,
//       child: ListView.separated(
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, index) => Stack(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                         isScrollControlled: true,
//                         context: context,
//                         backgroundColor: Colors.transparent,
//                         builder: (context) => BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                           child: JobDetail(
//                             jobList[index],
//                           ),
//                         ),
//                       );
//                     },
//                     child: JobItem(
//                       job: jobList[index],
//                     ),
//                   ),
//                 ],
//               ),
//           separatorBuilder: (_, index) => SizedBox(
//                 width: 15,
//               ),
//           itemCount: jobList.length),
//     );
//   }
// }

// class Job {
//   final String company;
//   final String logoUrl;
//   bool isMark;
//   final String title;
//   final String location;
//   final String time;
//   final List<String> req;
//   Job(this.company, this.logoUrl, this.isMark, this.title, this.location,
//       this.time, this.req);
//   static List<Job> generateJobs() {
//     return [
//       Job(
//         'Tigo',
//         'assets/tigo.png',
//         false,
//         'Principal Product Design',
//         '417 Marion , New York\nUnited States',
//         'Full Time',
//         [
//           'Bachelors degree in industrial design, manufacturing, engineering, or a related field.',
//           'A creative eye, good imagination, and vision.',
//           'A firm grasp of market trends and consumer preferences.',
//           'Practical experience using computer-aided design software.',
//           'Good technical and IT skills.'
//         ],
//       ),
//       Job(
//         'NMB Bank',
//         'assets/nmb.png',
//         false,
//         'Principal Product Design',
//         '417 Marion , New York\nUnited States',
//         'Full Time',
//         [
//           'Bachelors degree in industrial design, manufacturing, engineering, or a related field',
//           'A creative eye, good imagination, and vision',
//           'A firm grasp of market trends and consumer preferences',
//           'Practical experience using computer-aided design software',
//           'Good technical and IT skills'
//         ],
//       ),
//       Job(
//         'Red Company',
//         'assets/log.png',
//         false,
//         'Principal Product Design',
//         '417 Marion , New York\nUnited States',
//         'Full Time',
//         [
//           'Bachelors degree in industrial design, manufacturing, engineering, or a related field',
//           'A creative eye, good imagination, and vision',
//           'A firm grasp of market trends and consumer preferences',
//           'Practical experience using computer-aided design software',
//           'Good technical and IT skills'
//         ],
//       ),
//     ];
//   }

// }}

class Job_Item {
  final String id, company, jobTitle, jobType;
  List<dynamic> requirements;

  Job_Item(
    this.id,
    this.company,
    this.jobTitle,
    this.jobType,
    this.requirements,
  );
}
