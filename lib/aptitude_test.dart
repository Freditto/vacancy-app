import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

class AptitudeTestScreen extends StatefulWidget {
  @override
  State<AptitudeTestScreen> createState() => _AptitudeTestScreenState();
}

class _AptitudeTestScreenState extends State<AptitudeTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getSampleTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return SurveyKit(
                    onResult: (SurveyResult result) {
                      print(result.finishReason);
                      Navigator.pop(context);
                    },
                    task: task,
                    showProgress: true,
                    localizations: {
                      'cancel': 'Cancel',
                      'next': 'Next',
                    },
                    themeData: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.cyan,
                      ).copyWith(
                        onPrimary: Colors.white,
                      ),
                      primaryColor: Colors.black,
                      backgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        elevation: 0,
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.black,
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.black,
                        selectionColor: Colors.black,
                        selectionHandleColor: Colors.black,
                      ),
                      cupertinoOverrideTheme: CupertinoThemeData(
                        primaryColor: Colors.black,
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(150.0, 60.0),
                          ),
                          side: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return BorderSide(
                                  color: Colors.black,
                                );
                              }
                              return BorderSide(
                                color: Colors.black,
                              );
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                      color: Colors.black,
                                    );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                    color: Colors.black,
                                  );
                            },
                          ),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.button?.copyWith(
                                  color: Colors.cyan,
                                ),
                          ),
                        ),
                      ),
                      textTheme: TextTheme(
                        headline2: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                        headline5: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                        bodyText2: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        subtitle1: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                return CircularProgressIndicator.adaptive();
              },
            ),
          ),
        ),
      );
  }


  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'NMB Bank',
          text: 'Unakaribia kuanza majaribio kwa vigezo vya nafasi ya kazi',
          buttonText: 'Endelea!',
        ),
        QuestionStep(
          title: 'Aina ya Taarifa',
          text: 'Je unataka kutuma taarifa ya aina gain?',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Lalamiko', value: 'Lalamiko'),
              TextChoice(text: 'Maoni', value: 'Maoni'),
              TextChoice(text: 'Pendekezo', value: 'Pendekezo'),
              TextChoice(text: 'Pongezi', value: 'Pollen'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Tell us about you',
          text:
              'Tell us about yourself and why you want to improve your health.',
          answerFormat: TextAnswerFormat(
            maxLines: 5,
            validationRegEx: "^(?!\s*\$).+",
          ),
        ),
        // QuestionStep(
        //   title: 'How old are you?',
        //   answerFormat: IntegerAnswerFormat(
        //     defaultValue: 25,
        //     hint: 'Please enter your age',
        //   ),
        //   isOptional: true,
        // ),
        // QuestionStep(
        //   title: 'Medication?',
        //   text: 'Are you using any medication',
        //   answerFormat: BooleanAnswerFormat(
        //     positiveAnswer: 'Yes',
        //     negativeAnswer: 'No',
        //     result: BooleanResult.POSITIVE,
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Tell us about you',
        //   text:
        //       'Tell us about yourself and why you want to improve your health.',
        //   answerFormat: TextAnswerFormat(
        //     maxLines: 5,
        //     validationRegEx: "^(?!\s*\$).+",
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Select your body type',
        //   answerFormat: ScaleAnswerFormat(
        //     step: 1,
        //     minimumValue: 1,
        //     maximumValue: 5,
        //     defaultValue: 3,
        //     minimumValueDescription: '1',
        //     maximumValueDescription: '5',
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Known allergies',
        //   text: 'Do you have any allergies that we should be aware of?',
        //   isOptional: false,
        //   answerFormat: MultipleChoiceAnswerFormat(
        //     textChoices: [
        //       TextChoice(text: 'Penicillin', value: 'Penicillin'),
        //       TextChoice(text: 'Latex', value: 'Latex'),
        //       TextChoice(text: 'Pet', value: 'Pet'),
        //       TextChoice(text: 'Pollen', value: 'Pollen'),
        //     ],
        //   ),
        // ),
        // QuestionStep(
        //   title: 'Done?',
        //   text: 'We are done, do you mind to tell us more about yourself?',
        //   isOptional: true,
        //   answerFormat: SingleChoiceAnswerFormat(
        //     textChoices: [
        //       TextChoice(text: 'Yes', value: 'Yes'),
        //       TextChoice(text: 'No', value: 'No'),
        //     ],
        //     defaultSelection: TextChoice(text: 'No', value: 'No'),
        //   ),
        // ),
        // QuestionStep(
        //   title: 'When did you wake up?',
        //   answerFormat: TimeAnswerFormat(
        //     defaultValue: TimeOfDay(
        //       hour: 12,
        //       minute: 0,
        //     ),
        //   ),
        // ),
        // QuestionStep(
        //   title: 'When was your last holiday?',
        //   answerFormat: DateAnswerFormat(
        //     minDate: DateTime.utc(1970),
        //     defaultDate: DateTime.now(),
        //     maxDate: DateTime.now(),
        //   ),
        // ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey, we will contact you soon!',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    // task.addNavigationRule(
    //   forTriggerStepIdentifier: task.steps[6].stepIdentifier,
    //   navigationRule: ConditionalNavigationRule(
    //     resultToStepIdentifierMapper: (input) {
    //       switch (input) {
    //         case "Yes":
    //           return task.steps[0].stepIdentifier;
    //         case "No":
    //           return task.steps[7].stepIdentifier;
    //         default:
    //           return null;
    //       }
    //     },
    //   ),
    // );
    return Future.value(task);
  }
}