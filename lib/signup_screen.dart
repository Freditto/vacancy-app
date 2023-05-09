import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacancies_app/api/api.dart';
import 'package:vacancies_app/components/authentication_button.dart';
import 'package:vacancies_app/components/constants.dart';
import 'package:vacancies_app/components/custom_text_field.dart';
import 'package:vacancies_app/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static String id = 'SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();

  
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  // TextEditingController userPhoneController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                                color: kDarkGreenColor,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Create a new account',
                              style: GoogleFonts.poppins(
                                color: kGreyColor,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 40.0),
                      
                            TextFormField(
                                controller: firstNameController,
                                obscureText: true,
                                validator: validateFirstname,
                                // keyboardType: TextInputType.phone,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor: kGinColor,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 24.0,
                                    color: kDarkGreenColor,
                                  ),
                                  hintText: 'First Name',
                                  hintStyle: GoogleFonts.poppins(
                                    color: kDarkGreenColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: kGinColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: kDarkGreenColor),
                                  ),
                                ),
                              ),

                              TextFormField(
                                controller: lastNameController,
                                obscureText: true,
                                validator: validateLastname,
                                // keyboardType: TextInputType.phone,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor: kGinColor,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 24.0,
                                    color: kDarkGreenColor,
                                  ),
                                  hintText: 'Last Name',
                                  hintStyle: GoogleFonts.poppins(
                                    color: kDarkGreenColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: kGinColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: kDarkGreenColor),
                                  ),
                                ),
                              ),

                              TextFormField(
                                controller: userNameController,
                                obscureText: true,
                                validator: validateUsername,
                                // keyboardType: TextInputType.phone,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor: kGinColor,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 24.0,
                                    color: kDarkGreenColor,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: GoogleFonts.poppins(
                                    color: kDarkGreenColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: kGinColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: kDarkGreenColor),
                                  ),
                                ),
                              ),
                      
                              TextFormField(
                                controller: userEmailController,
                                obscureText: true,
                                validator: validateEmail,
                                // keyboardType: TextInputType.phone,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor: kGinColor,
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    size: 24.0,
                                    color: kDarkGreenColor,
                                  ),
                                  hintText: 'Email',
                                  hintStyle: GoogleFonts.poppins(
                                    color: kDarkGreenColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: kGinColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: kDarkGreenColor),
                                  ),
                                ),
                              ),
                      
                              TextFormField(
                                controller: userPasswordController,
                                obscureText: true,
                                validator: validatePassword,
                                // keyboardType: TextInputType.phone,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18.0),
                                  filled: true,
                                  fillColor: kGinColor,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 24.0,
                                    color: kDarkGreenColor,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.poppins(
                                    color: kDarkGreenColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: kGinColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: kDarkGreenColor),
                                  ),
                                ),
                              ),
                      
                              // TextFormField(
                              //   controller: userPasswordController,
                              //   obscureText: true,
                              //   validator: validatePassword,
                              //   // keyboardType: TextInputType.phone,
                              //   style: Theme.of(context).textTheme.bodyMedium,
                              //   decoration: InputDecoration(
                              //     contentPadding: const EdgeInsets.all(18.0),
                              //     filled: true,
                              //     fillColor: kGinColor,
                              //     prefixIcon: Icon(
                              //       Icons.lock,
                              //       size: 24.0,
                              //       color: kDarkGreenColor,
                              //     ),
                              //     hintText: 'Confirm Password',
                              //     hintStyle: GoogleFonts.poppins(
                              //       color: kDarkGreenColor,
                              //       fontWeight: FontWeight.w600,
                              //       fontSize: 15.0,
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //       borderSide: BorderSide(color: kGinColor),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //       borderSide:
                              //           BorderSide(color: kDarkGreenColor),
                              //     ),
                              //   ),
                              // ),
                      
                            CustomTextField(
                              hintText: 'Full Name',
                              icon: Icons.person,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            CustomTextField(
                              hintText: 'Email',
                              icon: Icons.mail,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            CustomTextField(
                              hintText: 'Password',
                              icon: Icons.lock,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            CustomTextField(
                              hintText: 'Confirm Password',
                              icon: Icons.lock,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'By signing you agree to our ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkGreenColor,
                                  ),
                                ),
                                Text(
                                  ' Terms of use',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: kGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'and ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkGreenColor,
                                  ),
                                ),
                                Text(
                                  ' privacy notice',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: kGreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: AuthenticationButton(
                          label: 'Sign Up',
                          onPressed: () {
                            _submit();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 20.0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: kDarkGreenColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Enter Valid Email';
    else
      return null;
  }

  String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String? validateFirstname(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length == 0)
      return 'Username Field must not be empty';
    // else if(value.length < 8)
    //   return 'Password must be of 8 or more digit';
    else
      return null;
  }

  String? validateLastname(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length == 0)
      return 'Username Field must not be empty';
    // else if(value.length < 8)
    //   return 'Password must be of 8 or more digit';
    else
      return null;
  }



  String? validateUsername(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length == 0)
      return 'Username Field must not be empty';
    // else if(value.length < 8)
    //   return 'Password must be of 8 or more digit';
    else
      return null;
  }

  String? validatePassword(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length == 0)
      return 'Password Field must not be empty';
    else if (value.length < 8)
      return 'Password must be of 8 or more digit';
    else
      return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA

      _register();
    }
  }

  void _register() async {
    // setState(() {
    //   _isLoading = true;
    // });

    // var number = userNumberController.text;
    // print(_countryCodes);
    // var code = _selectedCountryCode
    //     .toString()
    //     .substring(1, _selectedCountryCode.toString().length);
    // if (number.length == 10) {
    //   number = number.substring(1, number.length);
    // }
    // var cellphone = code + number;

// *******************************************************
    var data = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'username': userNameController.text,
      'email': userEmailController.text,
      'password': userPasswordController.text,
      'type' : 'seeker',
     
    };

    print(data);

    var res = await CallApi().authenticatedPostRequest(data, 'register');
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
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        // localStorage.setString("token", body['token']);
        localStorage.setString("user", json.encode(body));
        localStorage.setString("token", json.encode(body['token']));
        // localStorage.setString("phone_number", userNumberController.text);

        // setState(() {
        //   _isLoading = false;
        // });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else if (res.statusCode == 400) {
        print('hhh');
        // setState(() {
        //   _isLoading = false;
        //   _not_found = true;
        // });
      } else {}
    }

    // ignore: avoid_print
  }
}
