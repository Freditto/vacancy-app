import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies_app/api/api.dart';
import 'package:vacancies_app/login_screen.dart';
import 'package:vacancies_app/stepper_userdetail.dart';
import 'package:vacancies_app/utils/snackbar.dart';

class Personal_CV_Screen extends StatefulWidget {
  const Personal_CV_Screen({super.key});

  @override
  State<Personal_CV_Screen> createState() => _Personal_CV_ScreenState();
}

class _Personal_CV_ScreenState extends State<Personal_CV_Screen> {
  var currentStep = 0;

  final List<GlobalKey<FormState>> _formKeys = [];

  // File? file;

  var userData;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _getUserInfo();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.push(this.context,
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
    print(userData);
  }

  uploadProfile() async {
    print('Bra_______bra');
    var m = {
      'file':FileUploadsState.file!.path,
      'user_id': userData['user_id'].toString(),
      'last_job_title': WorkingExperienceState.controllerJobTitle.text,
      'institute_name': WorkingExperienceState.controllerinstitution.text,
      'supervisor_name': WorkingExperienceState.controllerSupervisorName.text,
      'supervisor_contact':
          WorkingExperienceState.controllerSupervisorContact.text,
      'starting_date': WorkingExperienceState.controllerStartDate.text,
      'end_date': WorkingExperienceState.controllerEndiDate.text,
      'o_level_index':
          Professional_QualificationState.controllerOLevelIndex.text,
      'education_level': Professional_QualificationState.chooseEducationValue,
      'program': Professional_QualificationState.controllerProgramName.text,
      'country': Professional_QualificationState.controllerCountry.text,
      'date_of_birth': PersonalState.controllerDateOfBirth.text,
      'gender': PersonalState.controllerGender.text,
      'phone': PersonalState.controllerMobileNo.text,
    };
    print(m);

    // print(file!.path);

    FormData formData = FormData.fromMap({
      "cv": await MultipartFile.fromFile(
        FileUploadsState.file!.path,

        filename: basename(FileUploadsState.file!.path,),
        // contentType:  MediaType("image", "jpg"), //add this
      ),
      'user_id': userData['user_id'].toString(),
      'last_job_title': WorkingExperienceState.controllerJobTitle.text,
      'institute_name': WorkingExperienceState.controllerinstitution.text,
      'supervisor_name': WorkingExperienceState.controllerSupervisorName.text,
      'supervisor_contact':
          WorkingExperienceState.controllerSupervisorContact.text,
      'starting_date': WorkingExperienceState.controllerStartDate.text,
      'end_date': WorkingExperienceState.controllerEndiDate.text,
      'o_level_index':
          Professional_QualificationState.controllerOLevelIndex.text,
      'education_level': Professional_QualificationState.chooseEducationValue,
      'program': Professional_QualificationState.controllerProgramName.text,
      'country': Professional_QualificationState.controllerCountry.text,
      'date_of_birth': PersonalState.controllerDateOfBirth.text,
      'gender': PersonalState.controllerGender.text,
      'phone': PersonalState.controllerMobileNo.text,
    });

    print(formData);

    var res = await CallApi()
        .authenticatedUploadRequest(formData, 'create_profile');
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
        showSnack(context, 'File Uploaded Successfully');

        Navigator.pop(this.context);

        setState(() {});
      } else if (res.statusCode == 400) {
        print('hhh');
        // setState(() {
        //   _isLoading = false;
        //   _not_found = true;
        // });
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: const Icon(Icons.person_2_outlined),
        content: const Personal(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: const Icon(Icons.school_outlined),
        content: const Professional_Qualification(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: const Icon(Icons.account_balance_outlined),
        content: const WorkingExperience(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      const Step(
        title: Icon(Icons.article_outlined),
        content: FileUploads(),
        state: StepState.complete,
        isActive: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text('Update CV'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        child: Stepper(
          currentStep: currentStep,
          steps: steps,
          type: StepperType.horizontal,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          onStepCancel: () {
            setState(() {
              currentStep > 0 ? currentStep -= 1 : currentStep = 0;
            });
          },
          onStepContinue: () {
            setState(() {
              currentStep < steps.length - 1
                  ? currentStep += 1
                  : uploadProfile();
            });

            // ++++++++++++++++++++++++++++++++++++++++++++++++++++
            // onStepContinue: () {
            //   setState(() {
            //     if (currentStep < steps.length - 1) {
            //       if (currentStep == 0 &amp;&amp;
            //           PersonalState.formKey.currentState.validate()) {
            //         currentStep = currentStep + 1;
            //       } else if (currentStep == 1 &amp;&amp;
            //           ContactState.formKey.currentState.validate()) {
            //         currentStep = currentStep + 1;
            //       }
            //     } else {
            //       currentStep = 0;
            //     }
            //   });
            // },
            // onStepCancel: () {
            //   setState(() {
            //     if (currentStep > 0) {
            //       currentStep = currentStep - 1;
            //     } else {
            //       currentStep = 0;
            //     }
            //   });
          },
        ),
      ),
    );
  }
}
