import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies_app/api/api.dart';
import 'package:vacancies_app/login_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var userData, next;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _getUserInfo();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });

    fetchAptitudeResultsListData(context);
  }

  Future<List<AptituteResult_Items>> fetchAptitudeResultsListData(
      context) async {
    print(" Inside List of Aptitude Results function");

    var res = await CallApi()
        .authenticatedGetRequest('api/getAttempts/${userData['user_id']}');

    print(res);
    if (res != null) {
      print(res.body);

      var aptitudeResultItensJson = json.decode(res.body);

      List<AptituteResult_Items> aptituderesultItems = [];

      for (var f in aptitudeResultItensJson) {
        AptituteResult_Items requestlistItems = AptituteResult_Items(
          f["job"].toString(),
          f["company"].toString(),
          f["percent"].toString(),
          f["status"].toString(),
          
          // f["longitude"].toString(),
          // f['is_received'].toString(),
        );
        aptituderesultItems.add(requestlistItems);
      }
      print(aptituderesultItems.length);

      return aptituderesultItems;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(child: _aptitudeResultListWidget()),
    );
  }

  Widget _aptitudeResultListWidget() {
    return FutureBuilder<List<AptituteResult_Items>>(
      future: fetchAptitudeResultsListData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              //itemCount: ProductModel.items.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => RequestMapScreen(
                    //               snapshot.data![index].latitude!,
                    //               snapshot.data![index].longitude!,
                    //             )));
                  },
                  onLongPress: () {
                    // _StatusDialog(
                    //   context,
                    //   snapshot.data![index].feed_id!,
                    // );
                  },
                  child: ListTile(
                      title: 
                        Text(
                            snapshot.data![index].job.toString(),
                          ),
                         
                      subtitle: snapshot.data![index].status! == 'pass'
                          ? Row(
                              children: [
                                Container(
                                  height: 30,
                                  // width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'You have pass the aptitude test, stay tune for next step ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  height: 30,
                                  // width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Sorry! you have failed the aptitude test, please try again later',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      // Text(snapshot.data![index].driver_id!,),
                      // leading: const Icon(Icons.person_2_outlined),
                      trailing: const Icon(Icons.more_vert)),
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class AptituteResult_Items {
  final String? job, company, percent, status;

  // jobtitle,
  // is_received;

  AptituteResult_Items(
    this.job,
    this.company,
    this.percent,
    this.status,
  );
}
