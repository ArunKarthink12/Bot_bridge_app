import 'package:botbridge_green/Utils/LocalDB.dart';
import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../ViewModel/SignInVM.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String latitude = "";
  String longitude = "";
  bool isshow = true;
//  getData() async {
//     LocalDB.getLDB( "latitude").then((value) {
//       setState(() {
//         latitude =value;
//       print("latitude: $latitude");

//       });
//     });

//     LocalDB.getLDB("longitude").then((value) {
//       setState(() {
//         longitude =value;
//        print(longitude);
//       });
//     });

//   }
  @override
  void initState() {
    // getData();
    // TODO: implement initState
    // _permission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomTheme.background_green,
        body: Stack(
          children: [
            Positioned(
                top: -height * 0.12,
                right: -width * 0.12,
                child: Container(
                  height: height * 0.4,
                  width: height * 0.4,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: CustomTheme.circle_green),
                )),
            Positioned(
                top: height * 0.135,
                right: width * 0.16,
                child: const Text(
                  "Let's Start !",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
            Positioned(
                bottom: -height * 0.12,
                left: -width * 0.12,
                child: Container(
                  height: height * 0.3,
                  width: height * 0.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: CustomTheme.circle_green),
                )),
            AnimatedPositioned(
              top: MediaQuery.of(context).viewInsets.bottom > 0.0
                  ? height * 0.03
                  : height * 0.3,
              left: MediaQuery.of(context).viewInsets.bottom > 0.0
                  ? width * 0.03
                  : width * 0.42,
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: 90),
              child: Image.asset(
                'assets/images/add_appointment.png',
                height: MediaQuery.of(context).viewInsets.bottom > 0.0
                    ? height * 0.05
                    : height * 0.08,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.18,
                        ),
                        SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: email,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.length < 4) {
                                  return "Please Enter Valid Username";
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white60)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white60)),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orangeAccent)),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orangeAccent)),
                                  errorStyle: const TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 12),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/images/user_name.png',
                                      height: 23,
                                      color: Colors.white,
                                    ),
                                  ),
                                  label: const Text(
                                    'Username',
                                    style: TextStyle(color: Colors.white60),
                                  )),
                            )),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                            width: width * 0.9,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: password,
                              obscureText: isshow,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.length < 2) {
                                  return "Please Enter Valid Password";
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white60)),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white60)),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orangeAccent)),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.orangeAccent)),
                                  errorStyle: const TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 12),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isshow = !isshow;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: isshow
                                          ? Image.asset(
                                              'assets/images/password.png',
                                              height: 23,
                                              color: Colors.white,
                                            )
                                          : Image.asset(
                                              'assets/images/unlock.png',
                                              height: 26,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                  label: const Text(
                                    'Password',
                                    style: TextStyle(color: Colors.white60),
                                  )),
                            )),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 12),
                            ),
                            SizedBox(width: width * 0.05),
                          ],
                        ),
                        SizedBox(height: height * 0.04),
                        SizedBox(
                          width: 150,
                          height: 45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                elevation: MaterialStateProperty.all(7)),
                            onPressed: () {
                              // NavigateController.pagePush(context, const HomeView());
                              Map<String, dynamic> data = {
                                "userName": email.text,
                                "password": password.text,
                                "deviceType": "ANDROID",
                                "requestType": "",
                                "latitude": "",
                                "longitude": ""
                              };
                              print("Login Request $data");
                              if (_formkey.currentState!.validate()) {
                                SignInVM foodNotifier = Provider.of<SignInVM>(
                                    context,
                                    listen: false);
                                loginMain(context, data, foodNotifier, true);
                                LocalDB.setLDB("UID", email.text.toString());
                              }
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 14),
                            ),
                            Text(
                              'SignUp',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

//   void _permission() async {
//     var accessLocation = await Permission.location.status;

//     if (!accessLocation.isGranted) {
//       await Permission.location.request();
//     }

//     if (await Permission.location.isGranted) {
//       print("done");
//     } else {
//       SystemNavigator.pop();
//     }
//   }
}
