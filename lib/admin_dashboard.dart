import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies_app/admin_add_vacancy.dart';
import 'package:vacancies_app/api/api.dart';
import 'package:vacancies_app/login_screen.dart';
import 'package:vacancies_app/utils/custom_list_tile.dart';
import 'package:vacancies_app/utils/snackbar.dart';

class AdminDasboard extends StatefulWidget {
  const AdminDasboard({super.key});

  @override
  State<AdminDasboard> createState() => _AdminDasboardState();
}

class _AdminDasboardState extends State<AdminDasboard> {
  var userData, next;

  List<Job_Item>? job_data;

  TextEditingController requirementController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answer_A_Controller = TextEditingController();
  TextEditingController answer_B_Controller = TextEditingController();
  TextEditingController answer_C_Controller = TextEditingController();

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
      List<Job_Item> jobItems0 = [];
      if (next != null) {
        jobItems0 = job_data!;
      }

      for (var f in jobItensJson) {
        Job_Item jobItems = Job_Item(
          f['id'].toString(),
          f['company'].toString(),
          f['jobTitle'].toString(),
          f['jobType'].toString(),
          f['requirements'],
        );
        jobItems0.add(jobItems);
      }
      print(jobItems0.length);
      // setState(() {
      //   loading = false;
      // });

      setState(() {
        job_data = jobItems0;
      });
    } else {
      showSnack(context, 'No network');
      return [];
    }
  }

  _logoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: const Text(
                    "Are you sure you want to logout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();
                            Navigator.of(context).pop();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text('Yes')),

                      const SizedBox(
                        width: 30,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // }
                    ])
              ],
            ),
          );
        });
  }

  Future<void> _show_Action_Dialog(int index) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('AlertDialog Title'),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                    child: CustomListTile(
                      "Add Requirement",
                      Icons.edit_outlined,
                      Icons.keyboard_arrow_right_outlined,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _add_requirement_Dialog(context, index);
                    }),

                InkWell(
                    child: CustomListTile(
                      "Add Question",
                      Icons.edit_outlined,
                      Icons.keyboard_arrow_right_outlined,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _add_question_Dialog(context, index);
                    }),

                InkWell(
                  child: CustomListTile(
                    "Delete",
                    Icons.delete_outline,
                    Icons.keyboard_arrow_right_outlined,
                  ),
                  onTap: () {
                    // _delete_Product_API(index);
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
                // Text('Are you sure you want to logout.'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Yes'),
          //     onPressed: () async {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   TextButton(
          //     child: const Text('No'),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  _add_requirement_Dialog(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Requirement'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  maxLines: 5,
                  controller: requirementController,
                  // validator: validateUsername,
                  // keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      // borderSide: BorderSide.none,
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Add requirenemtn here...',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            // _deleteSingleProductTocart(index);
                            // logOUT_User();
                            _add_requirement_API(id);
                            // Navigator.of(context).pop();
                          },
                          child: const Text('Yes')),

                      const SizedBox(
                        width: 30,
                      ),

                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No')),
                      // onPressed: () {
                      //   Navigator.of(context).pop();
                      // }
                    ])
              ],
            ),
          );
        });
  }

  _add_requirement_API(int id) async {
    var data = {
      'requirement': requirementController.text,
      'vac_id': id,
    };

    print(data);

    var res =
        await CallApi().authenticatedPostRequest(data, 'api/addRequirement');
    if (res == null) {
      // setState(() {
      //   _isLoading = false;
      //   // _not_found = true;
      // });
      // showSnack(context, 'No Network!');
    } else {
      var body = json.decode(res!.body);
      print(body);

      if (res.statusCode == 200) {
        showSnack(context, 'Question successfull added!');
        Navigator.pop(context);
      } else if (body['msg'] == 'fail') {
        print('hhh');
        // setState(() {
        //   _isLoading = false;
        //   _not_found = true;
        // });
      } else {}
    }
  }

  _add_question_API(int id) async {
    var data = questionsToAdd;

    print(data);

    var res = await CallApi()
        .authenticatedPostRequest(data, 'api/setQuestion/' + id.toString());
    if (res == null) {
      // setState(() {
      //   _isLoading = false;
      //   // _not_found = true;
      // });
      // showSnack(context, 'No Network!');
    } else {
      var body = json.decode(res!.body);
      print(body);

      if (res.statusCode == 200) {
        setState(() {
          questionsToAdd = [];
        });
        showSnack(context, 'Question successfull added!');
        Navigator.pop(context);
      } else if (body['msg'] == 'fail') {
        print('hhh');
        // setState(() {
        //   _isLoading = false;
        //   _not_found = true;
        // });
      } else {}
    }
  }

  List<Map<String, dynamic>>? questionsToAdd = [];
  checkQuestion() {
    // var ans_list = [1, 2, 3];
    var stateA = false;
    var stateB = false;
    var stateC = false;
    // const myPI = 3142;
    // int r = (radians * 1000).round();

    switch (_checked) {
      case 1:
        stateA = true;
        break;
      case 2:
        stateB = true;
        break;
      case 3:
        stateC = true;
        break;
    }
    var answers = [
      {'answer': answer_A_Controller.text, 'is_correct': stateA},
      {'answer': answer_B_Controller.text, 'is_correct': stateB},
      {'answer': answer_C_Controller.text, 'is_correct': stateC}
    ];
    var questions = {
      'question': questionController.text,
      'is_checkable': false,
      'answer': answers
    };
    print(questions);
    questionsToAdd!.add(questions);
    setState(() {
      questionController.clear();
      answer_A_Controller.clear();
      answer_B_Controller.clear();
      answer_C_Controller.clear();
    });
  }

  var _checked = 1;

  _add_question_Dialog(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Question'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      maxLines: 5,
                      controller: questionController,
                      // validator: validateUsername,
                      // keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          // borderSide: BorderSide.none,
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Add Question here...',
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RadioListTile(
                      title: TextFormField(
                        controller: answer_A_Controller,
                        // validator: validateUsername,
                        // keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            // borderSide: BorderSide.none,
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Answer A',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                      value: 1,
                      groupValue: _checked,
                      onChanged: (value) {
                        setState(() {
                          _checked = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RadioListTile(
                      title: TextFormField(
                        controller: answer_B_Controller,
                        // validator: validateUsername,
                        // keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            // borderSide: BorderSide.none,
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Answer B',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                      value: 2,
                      groupValue: _checked,
                      onChanged: (value) {
                        setState(() {
                          _checked = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RadioListTile(
                      title: TextFormField(
                        controller: answer_C_Controller,
                        // validator: validateUsername,
                        // keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            // borderSide: BorderSide.none,
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Answer C',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                      value: 3,
                      groupValue: _checked,
                      onChanged: (value) {
                        setState(() {
                          _checked = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                // _deleteSingleProductTocart(index);
                                // logOUT_User();
                                checkQuestion();
                                Navigator.of(context).pop();
                                _add_question_Dialog(context, id);
                              },
                              child: const Text('Next question')),

                          const SizedBox(
                            width: 30,
                          ),

                          InkWell(
                              onTap: () {
                                checkQuestion();
                                _add_question_API(id);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save question')),
                          // onPressed: () {
                          //   Navigator.of(context).pop();
                          // }
                        ])
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _logoutDialog(context);
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: SafeArea(child: _jobListWidget()),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Admin_Add_VacancyScreen(),
                ));
          }),
    );
  }

  Widget _jobListWidget() {
    if (job_data == null) {
      return const Center(
        child: Text('No Data...'),
      );
    } else if (job_data != null && job_data!.isEmpty) {
      // No Data
      return const Center(
        child: Text('No Data or No jobs yet...'),
      );
    } else {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: job_data!.length,
          //itemCount: ProductModel.items.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DetailStationsry(
                //               snapshot.data![index].id!,
                //               snapshot.data![index].username!,
                //               snapshot.data![index].phone!,
                //               snapshot.data![index].description!,

                //             )));
              },
              child: ListTile(
                  title: Text(
                    job_data![index].company,
                  ),
                  subtitle: Text(
                    job_data![index].jobTitle,
                  ),
                  // leading: Icon(Icons.person_2_outlined),
                  trailing: InkWell(
                      onTap: () {
                        _show_Action_Dialog(int.parse(job_data![index].id));
                      },
                      child: const Icon(Icons.more_vert))),
            );
          });
    }
  }
}

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
