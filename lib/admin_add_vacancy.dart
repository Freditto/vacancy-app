import 'package:flutter/material.dart';

class Admin_Add_VacancyScreen extends StatefulWidget {
  const Admin_Add_VacancyScreen({super.key});

  @override
  State<Admin_Add_VacancyScreen> createState() =>
      _Admin_Add_VacancyScreenState();
}

class _Admin_Add_VacancyScreenState extends State<Admin_Add_VacancyScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController companyController = TextEditingController();
  TextEditingController jobtitleController = TextEditingController();

  String? chosenStatus;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Job'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        elevation: 0,

      ),


      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: companyController,
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
                          hintText: 'Company Name',
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
                        height: 30,
                      ),
              
                      TextFormField(
                        controller: jobtitleController,
                        // validator: validatePassword,
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
                          hintText: 'Job Title',
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
                        height: 30,
                      ),

                      Container(
                      // padding: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 0, bottom: 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButton<String>(
                        value: chosenStatus,
                        //elevation: 5,
                        // style: TextStyle(color: Colors.black),

                        hint: const Text('Select Tob Type'),
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        underline: const SizedBox(),
                        style: const TextStyle(color: Colors.black, fontSize: 15),

                        items: <String>[
                          'Full Time',
                          'Part Time',
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
                            chosenStatus = value;
                            // _visible_tag = v;
                          });
                        },
                      ),
                    ),
                    ],
                  ),
                ),
              
                const SizedBox(
                  height: 30,
                ),
              
                MaterialButton(
                  elevation: 0,
                  color: Colors.green,
                  height: 50,
                  minWidth: 500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () {
                    // _submit();
                    // _login();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AdminDasboard(),
                    //   ),
                    // );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              
                // const SizedBox(
                //   height: 200,
                // ),
              
                // _contentOverView(),
                // const SizedBox(
                //   height: 30,
                // ),
              
                const SizedBox(
                  height: 30,
                ),
                
              ],
            ),
          ),
        ),
    );
  }
}
