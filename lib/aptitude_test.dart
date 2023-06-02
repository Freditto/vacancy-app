import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_kit/survey_kit.dart' as step;
import 'package:vacancies_app/api/api.dart';
import 'package:vacancies_app/login_screen.dart';
import 'package:vacancies_app/utils/snackbar.dart';

class AptitudeTestScreen extends StatefulWidget {
  final String jobid, company;

  // bool is_secured, is_folder;
  const AptitudeTestScreen(this.jobid, this.company, {super.key});

  @override
  State<AptitudeTestScreen> createState() => _AptitudeTestScreenState();
}

class _AptitudeTestScreenState extends State<AptitudeTestScreen> {
  var userData, next;
  var questionResults;

  List<Question_Item>? question_data;

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
    fetchQuestionData();
  }

  fetchQuestionData() async {
    // var customer = userData['id'].toString();
    String url = 'api/getQuestion/${widget.jobid}';
    // if (next != null) {
    //   url = url_format(next);
    // }
    var res = await CallApi().authenticatedGetRequest(url, context: context);

    print(res);
    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      var questionItensJson = body;
      List<Question_Item> questionItems0 = [];
      if (next != null) {
        questionItems0 = question_data!;
      }

      for (var f in questionItensJson) {
        Question_Item questionItems = Question_Item(
          f['id'].toString(),
          f['question'].toString(),
          f['answer'],
        );
        questionItems0.add(questionItems);
      }
      print(questionItems0.length);
      // setState(() {
      //   loading = false;
      // });

      // setState(() {
      //   question_data = _question_items;
      // });
      return questionItems0;
    } else {
      showSnack(context, 'No network');
      return [];
    }
  }

  void _postAptitudeResults() async {
// *******************************************************
    var data = questionResults;

    print(data);

    var res = await CallApi().authenticatedPostRequest(data, 'api/setAnswer/'+userData['user_id'].toString());
    if (res == null) {
    } else {
      var body = json.decode(res!.body);
      print(body);

      if (res.statusCode == 200) {
        if (body['success'] == true) {
          _successDialog(context, body['percent'].toString(), body['status']);
        } else if (body['success'] == false) {
          _failedDialog(context, body['message']);
        }
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

  _successDialog(BuildContext context, String percent, String status) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    "Percent scored : $percent% Status :$status",
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
                
              ],
            ),
          );
        });
  }

  _failedDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    message,
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
                
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<step.Task>(
            future: getSampleTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                final task = snapshot.data!;
                return step.SurveyKit(
                  onResult: (step.SurveyResult result) {
                    print(snapshot.data!.toJson()['steps'][1]['title']);
                    print(snapshot.data!.toJson()['steps'].length);
                    print(result.results.length);

                    print("_________________");
                    //for answer
                    print(result.results[5].results[0].result.value);
                    // print(result.results[1].results[0]);
                    var questionResult = [];
                    print("object ----------");
                    print(snapshot.data!.toJson()['steps'].length);

                    for (int x = 0;
                        x < snapshot.data!.toJson()['steps'].length;
                        x++) {
                      if (x == 0) {
                        print('at 0 --------');
                        continue;
                      } else if (x ==
                          snapshot.data!.toJson()['steps'].length - 1) {
                        continue;
                      } else {
                        questionResult.add({
                          'question_id': snapshot.data!.toJson()['steps'][x]
                              ['title'],
                          'answer_id': result.results[x].results[0].result.value
                        });
                      }
                    }
                    var dataToSend = {
                      'vac_id': int.parse(widget.jobid),
                      'user_id': userData['user_id'],
                      'answers': questionResult
                    };
                    setState(() {
                      questionResults = dataToSend;
                    });
                    print(dataToSend);
                    _postAptitudeResults();

                    Navigator.pop(context);
                  },
                  task: task,
                  showProgress: true,
                  localizations: const {
                    'cancel': 'Cancel',
                    'next': 'Next',
                  },
                  themeData: Theme.of(context).copyWith(
                    primaryColor: Colors.black,
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
                    textSelectionTheme: const TextSelectionThemeData(
                      cursorColor: Colors.black,
                      selectionColor: Colors.black,
                      selectionHandleColor: Colors.black,
                    ),
                    cupertinoOverrideTheme: const CupertinoThemeData(
                      primaryColor: Colors.black,
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(150.0, 60.0),
                        ),
                        side: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return const BorderSide(
                                color: Colors.black,
                              );
                            }
                            return const BorderSide(
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
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                  );
                            }
                            return Theme.of(context)
                                .textTheme
                                .labelLarge
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
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Colors.cyan,
                              ),
                        ),
                      ),
                    ),
                    textTheme: const TextTheme(
                      displayMedium: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black,
                      ),
                      headlineSmall: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      bodyMedium: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      titleMedium: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    inputDecorationTheme: const InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.cyan,
                    )
                        .copyWith(
                          onPrimary: Colors.white,
                        )
                        .copyWith(background: Colors.white),
                  ),
                  surveyProgressbarConfiguration:
                      step.SurveyProgressConfiguration(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      ),
    );
  }

  question() async {
    List<step.Step> widgets = [
      step.InstructionStep(
        title: widget.company,
        text: 'Unakaribia kuanza majaribio kwa vigezo vya nafasi ya kazi',
        buttonText: 'Endelea!',
      )
    ];

    for (Question_Item question in await fetchQuestionData()!) {
      widgets.add(step.QuestionStep(
        title: question.id.toString(),
        text: question.question,
        // value: ,
        isOptional: false,
        answerFormat: step.SingleChoiceAnswerFormat(
          textChoices: await answers(question.answer),
          // textChoices: [
          //   step.TextChoice(text: 'Lalamiko', value: 'Lalamiko'),
          //   step.TextChoice(text: 'Maoni', value: 'Maoni'),
          //   step.TextChoice(text: 'Pendekezo', value: 'Pendekezo'),
          //   step.TextChoice(text: 'Pongezi', value: 'Pollen'),
          // ],
        ),
      ));
    }
    widgets.add(
      step.CompletionStep(
        stepIdentifier: step.StepIdentifier(id: '321'),
        text: 'Thanks for taking the aptitude test, we will contact you soon!',
        title: 'Done!',
        buttonText: 'Submit',
      ),
    );
    print(widgets);

    return widgets;
  }

  answers(dynamic answer) async {
    List<step.TextChoice> widget = [];
    for (dynamic x in answer) {
      widget.add(
        step.TextChoice(text: x['answer'], value: x['id'].toString()),
      );
    }
    return widget;
  }

  Future<step.Task> getSampleTask() async {
    var task = step.NavigableTask(
      id: step.TaskIdentifier(),
      steps: await question(),
      // steps: [
      //   InstructionStep(
      //     title: widget.company,
      //     text: 'Unakaribia kuanza majaribio kwa vigezo vya nafasi ya kazi',
      //     buttonText: 'Endelea!',
      //   ),
      //   QuestionStep(
      //     title: 'Aina ya Taarifa',
      //     text: 'Je unataka kutuma taarifa ya aina gain?',
      //     isOptional: false,
      //     answerFormat: SingleChoiceAnswerFormat(
      //       textChoices: [
      //         TextChoice(text: 'Lalamiko', value: 'Lalamiko'),
      //         TextChoice(text: 'Maoni', value: 'Maoni'),
      //         TextChoice(text: 'Pendekezo', value: 'Pendekezo'),
      //         TextChoice(text: 'Pongezi', value: 'Pollen'),
      //       ],
      //     ),
      //   ),
      //   QuestionStep(
      //     title: 'Tell us about you',
      //     text:
      //         'Tell us about yourself and why you want to improve your health.',
      //     answerFormat: TextAnswerFormat(
      //       maxLines: 5,
      //       validationRegEx: "^(?!\s*\$).+",
      //     ),
      //   ),
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
      // CompletionStep(
      //   stepIdentifier: StepIdentifier(id: '321'),
      //   text: 'Thanks for taking the survey, we will contact you soon!',
      //   title: 'Done!',
      //   buttonText: 'Submit survey',
      // ),
      // ],
    );
    // task.addNavigationRule(
    //   forTriggerStepIdentifier: task.steps[2].stepIdentifier,
    //   navigationRule: step.ConditionalNavigationRule(
    //     resultToStepIdentifierMapper: (input) {
    //       switch (input) {
    //         case "Yes":
    //           return task.steps[0].stepIdentifier;
    //         case "No":
    //           return task.steps[1].stepIdentifier;
    //         default:
    //           return null;
    //       }
    //     },
    //   ),
    // );
    return Future.value(task);
  }
}

class Question_Item {
  final String id, question;
  List<dynamic> answer;

  Question_Item(
    this.id,
    this.question,
    this.answer,
  );
}
