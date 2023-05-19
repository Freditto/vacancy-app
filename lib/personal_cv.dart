import 'package:flutter/material.dart';
import 'package:vacancies_app/stepper_userdetail.dart';

class Personal_CV_Screen extends StatefulWidget {
  const Personal_CV_Screen({super.key});

  @override
  State<Personal_CV_Screen> createState() => _Personal_CV_ScreenState();
}

class _Personal_CV_ScreenState extends State<Personal_CV_Screen> {

  var currentStep = 0;

  



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
                  : currentStep = 0;
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
