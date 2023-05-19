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
  static final formKey = GlobalKey<FormState>();
  static TextEditingController controllerFirstName =
      TextEditingController();
  static TextEditingController controllerLastName = TextEditingController();
  static TextEditingController controllerDateOfBirth =
      TextEditingController();
  static TextEditingController controllerGender = TextEditingController();

  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKey,
      // autovalidateMode: false,
      child: Column(
        children: <Widget>[
          TextFormField(
            maxLines: 1,
            controller: controllerFirstName,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.grey,
              ),
              hintText: 'First Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              return null;
            
              // if (value.trim().isEmpty) {
              //   return "First Name is Required";
              // }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                hintText: 'Last Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              validator: (value) {
                return null;
              
                // if (value.trim().isEmpty) {
                //   return "Last Name is Required";
                // }
              },
              controller: controllerLastName),
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
          const SizedBox(height: 20),
          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Email',
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
            controller: controllerEmail,
          ),
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

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContactState();
  }
}

class ContactState extends State<Contact> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKey,
      // autovalidate: false,
      child: Column(
        children: <Widget>[
          TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Colors.grey,
              ),
              hintText: 'Email',
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
            controller: controllerEmail,
          ),
          const SizedBox(height: 20),
          TextFormField(
            minLines: 5,
            maxLines: 7,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              hintText: 'Address',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            controller: controllerAddress,
          ),
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
  State<Professional_Qualification> createState() =>
      _Professional_QualificationState();
}

class _Professional_QualificationState
    extends State<Professional_Qualification> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  String? chooseEducationValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKey,
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
            controller: controllerEmail,
          ),
          const SizedBox(height: 20),

          Container(
            // padding: const EdgeInsets.all(0.0),
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 0),
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
            controller: controllerMobileNo,
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
            controller: controllerMobileNo,
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
  State<WorkingExperience> createState() => _WorkingExperienceState();
}

class _WorkingExperienceState extends State<WorkingExperience> {
  static final formKey = GlobalKey<FormState>();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  static TextEditingController controllerStartDate =
      TextEditingController();

  static TextEditingController controllerEndiDate = TextEditingController();

  String? chooseEducationValue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
      key: formKey,
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
            controller: controllerEmail,
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
            controller: controllerEmail,
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
            controller: controllerEmail,
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
            controller: controllerEmail,
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
  State<FileUploads> createState() => _FileUploadsState();
}

class _FileUploadsState extends State<FileUploads> {

  _selecFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      print(files);
    } else {
      // User canceled the picker
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10, right: 10, left: 10),
            child: DottedBorder(
              color: Colors.grey,
              strokeWidth: 2,
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              dashPattern: const [15, 10],
              child: GestureDetector(
                onTap: () {
                  _selecFiles();
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
        ],
      ),
    );
  }
}
