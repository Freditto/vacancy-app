import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonalState();
  }
}

class PersonalState extends State<Personal> {
  static final formKeyPersonal = GlobalKey<FormState>();
  // static TextEditingController controllerFirstName =
  //     TextEditingController();
  // static TextEditingController controllerLastName = TextEditingController();
  static TextEditingController controllerDateOfBirth = TextEditingController();
  static TextEditingController controllerGender = TextEditingController();

  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKeyPersonal,
      // autovalidateMode: false,
      child: Column(
        children: <Widget>[
          // TextFormField(
          //   maxLines: 1,
          //   controller: controllerFirstName,
          //   decoration: const InputDecoration(
          //     prefixIcon: Icon(
          //       Icons.person,
          //       color: Colors.grey,
          //     ),
          //     hintText: 'First Name',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //     ),
          //   ),
          //   validator: (value) {
          //     return null;

          //     // if (value.trim().isEmpty) {
          //     //   return "First Name is Required";
          //     // }
          //   },
          // ),
          // const SizedBox(height: 20),
          // TextFormField(
          //     maxLines: 1,
          //     decoration: const InputDecoration(
          //       prefixIcon: Icon(
          //         Icons.person,
          //         color: Colors.grey,
          //       ),
          //       hintText: 'Last Name',
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //       ),
          //     ),
          //     validator: (value) {
          //       return null;

          //       // if (value.trim().isEmpty) {
          //       //   return "Last Name is Required";
          //       // }
          //     },
          //     controller: controllerLastName),
          const SizedBox(height: 20),
          TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
                hintText: 'Date of Birth',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    controllerDateOfBirth.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
              controller: controllerDateOfBirth),
          const SizedBox(height: 20),
          TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                hintText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              controller: controllerGender),
          // const SizedBox(height: 20),
          // TextFormField(
          //   maxLines: 1,
          //   decoration: const InputDecoration(
          //     prefixIcon: Icon(
          //       Icons.email,
          //       color: Colors.grey,
          //     ),
          //     hintText: 'Email',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //     ),
          //   ),
          //   validator: (value) {
          //     return null;

          //     // if (value.trim().isEmpty) {
          //     //   return "Email is Required";
          //     // }
          //   },
          //   controller: controllerEmail,
          // ),
          const SizedBox(height: 20),
          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              hintText: 'Mobile No',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Mobile No is Required";
              // }
            },
            controller: controllerMobileNo,
          ),
        ],
      ),
    ));
  }
}

class Professional_Qualification extends StatefulWidget {
  const Professional_Qualification({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Professional_QualificationState();
  }

  
}

class Professional_QualificationState
    extends State<Professional_Qualification> {
  static final formKeyProfessional = GlobalKey<FormState>();
  static TextEditingController controllerOLevelIndex = TextEditingController();
  static TextEditingController controllerProgramName = TextEditingController();
  static TextEditingController controllerCountry = TextEditingController();

  static String? chooseEducationValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKeyProfessional,
      // autovalidate: false,
      child: Column(
        children: <Widget>[
          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              // prefixIcon: const Icon(
              //   Icons.email,
              //   color: Colors.grey,
              // ),
              hintText: 'O-Level | A-Level Index No',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Email is Required";
              // }
            },
            controller: controllerOLevelIndex,
          ),
          const SizedBox(height: 20),

          Container(
            // padding: const EdgeInsets.all(0.0),
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 0, bottom: 0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12)),
            child: DropdownButton<String>(
              value: chooseEducationValue,
              //elevation: 5,
              // style: TextStyle(color: Colors.black),

              hint: const Text('Select Education Level'),
              dropdownColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 36,
              isExpanded: true,
              underline: const SizedBox(),
              style: const TextStyle(color: Colors.black, fontSize: 15),

              items: <String>[
                'Bachelor',
                'Diploma',
                'Certificate',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              onChanged: (String? value) {
                print(value);
                // var v = '0';
                // if (value == 'Revenue') {
                //   v = '1';
                // }
                setState(() {
                  chooseEducationValue = value;
                  // _visible_tag = v;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              // prefixIcon: const Icon(
              //   Icons.phone,
              //   color: Colors.grey,
              // ),
              hintText: 'Program Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Mobile No is Required";
              // }
            },
            controller: controllerProgramName,
          ),

          const SizedBox(height: 20),

          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              // prefixIcon: const Icon(
              //   Icons.phone,
              //   color: Colors.grey,
              // ),
              hintText: 'Country',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Mobile No is Required";
              // }
            },
            controller: controllerCountry,
          ),

          // TextFormField(
          //   minLines: 5,
          //   maxLines: 7,
          //   decoration: InputDecoration(
          //     prefixIcon: const Icon(
          //       Icons.home,
          //       color: Colors.grey,
          //     ),
          //     hintText: 'Address',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //     ),
          //   ),
          //   controller: controllerAddress,
          // ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}

class WorkingExperience extends StatefulWidget {
  const WorkingExperience({super.key});

  @override
  State<WorkingExperience> createState() => WorkingExperienceState();
}

class WorkingExperienceState extends State<WorkingExperience> {
  static final formKeyWorkingExperience = GlobalKey<FormState>();
  static TextEditingController controllerJobTitle = TextEditingController();
  static TextEditingController controllerinstitution = TextEditingController();
  static TextEditingController controllerSupervisorName =
      TextEditingController();
  static TextEditingController controllerSupervisorContact =
      TextEditingController();

  static TextEditingController controllerStartDate = TextEditingController();

  static TextEditingController controllerEndiDate = TextEditingController();

  String? chooseEducationValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKeyWorkingExperience,
      // autovalidate: false,
      child: Column(
        children: <Widget>[
          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              // prefixIcon: const Icon(
              //   Icons.email,
              //   color: Colors.grey,
              // ),
              hintText: 'Job Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Email is Required";
              // }
            },
            controller: controllerJobTitle,
          ),
          const SizedBox(height: 20),

          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              // prefixIcon: const Icon(
              //   Icons.email,
              //   color: Colors.grey,
              // ),
              hintText: 'Institution Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Email is Required";
              // }
            },
            controller: controllerinstitution,
          ),
          const SizedBox(height: 20),

          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              // prefixIcon: const Icon(
              //   Icons.email,
              //   color: Colors.grey,
              // ),
              hintText: 'Supervisor Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Email is Required";
              // }
            },
            controller: controllerSupervisorName,
          ),
          const SizedBox(height: 20),

          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              // prefixIcon: const Icon(
              //   Icons.email,
              //   color: Colors.grey,
              // ),
              hintText: 'Supervisor Contact',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;

              // if (value.trim().isEmpty) {
              //   return "Email is Required";
              // }
            },
            controller: controllerSupervisorContact,
          ),
          const SizedBox(height: 20),

          TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
                hintText: 'Start Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    controllerStartDate.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
              controller: controllerStartDate),

          const SizedBox(height: 20),

          TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
                hintText: 'End Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    controllerEndiDate.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
              controller: controllerEndiDate),

          // TextFormField(
          //   minLines: 5,
          //   maxLines: 7,
          //   decoration: InputDecoration(
          //     prefixIcon: const Icon(
          //       Icons.home,
          //       color: Colors.grey,
          //     ),
          //     hintText: 'Address',
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //     ),
          //   ),
          //   controller: controllerAddress,
          // ),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}

class FileUploads extends StatefulWidget {
  const FileUploads({super.key});

  @override
  State<FileUploads> createState() => FileUploadsState();
}

class FileUploadsState extends State<FileUploads> {
  _selecFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      print(files);
    } else {
      // User canceled the picker
    }
  }

  static final formKeyFileUpload = GlobalKey<FormState>();

  var userData;
  var rootid;
  var result;
  var status;

  var fileName;

  // selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //     allowMultiple: false,
  //   );

  //   if (result == null) {
  //     return;
  //   } else {
  //     file = File(result.files.single.path!);

  //     // List<File> files = result.paths.map((path) => File(path!)).toList();

  //     // print(result.files.single.path);
  //     print(file);

  //     setState(() {
  //       // file = File(path);
  //       // uploadFilePhaseZero();
  //     });

  //     print("file============$file");
  //     print("path============${file!.path}");
  //     // print("file============"+file!);

  //     // uploadFilePhaseOneDio();

  //     Navigator.of(this.context).push(
  //         MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));
  //   }

  //   // ignore: unnecessary_null_comparison
  //   if (file!.path == null) {}
  // }

  static File? file;

  selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) {
      return;
    } else {

      // List<File> files = result.paths.map((path) => File(path!)).toList();

      // print(result.files.single.path);
      print(file);

      setState(() {
      file = File(result.files.single.path!);
        // file = File(path);
        // uploadFile();
      });

      print("file============" + file.toString());
      print("path============" + file!.path.toString());
      // print("file============"+file!);

      // uploadFilePhaseOneDio();
    }

    if (file!.path == null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Form(
            key: formKeyFileUpload,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: DottedBorder(
                color: Colors.grey,
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                dashPattern: const [15, 10],
                child: GestureDetector(
                  onTap: () {
                    // _selecFiles();
                    selectFile();
                  },
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                        color: Colors.grey[300],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(
                          //   'assets/image.svg',
                          //   width: 32,
                          //   color: Colors.black,
                          // ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'No pdf file Selected',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
