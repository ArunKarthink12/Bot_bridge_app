import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/AddPrescriptionView.dart';
import 'package:botbridge_green/View/AppointmentView.dart';
import 'package:botbridge_green/View/CollectedSamplesView.dart';
import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:botbridge_green/View/HistoryView.dart';
import 'package:botbridge_green/View/NewBookingView.dart';
import 'package:botbridge_green/View/NewRequestView.dart';
import 'package:botbridge_green/View/PatientDetailsView.dart';
import 'package:botbridge_green/View/PaymentView.dart';
import 'package:botbridge_green/View/ServicesView.dart';
import 'package:botbridge_green/View/upipayView.dart';
import 'package:botbridge_green/ViewModel/BookedServiceVM.dart';
import 'package:botbridge_green/controller/locationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Utils/LocalDB.dart';
import 'Helper/Drawer.dart';

LocationController locationController = Get.put(LocationController());

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String userName = "";
  int venueNo = 0;
  int venueBranchNo = 0;
  int userno = 0;

  getData() async {
    LocalDB.getLDB("AccountName").then((value) {
      setState(() {
        userName = value;
      });
    });
    LocalDB.getLDB("venueNo").then((value) {
      setState(() {
        venueNo = int.parse(value);
      });
    });
    LocalDB.getLDB("venueBranchNo").then((value) {
      setState(() {
        venueBranchNo = int.parse(value);
      });
    });

    LocalDB.getLDB("latitude").then((value) {
      setState(() {
        //   latitude =value;
        // print("latitude: $latitude");
      });
    });

    LocalDB.getLDB("longitude").then((value) {
      setState(() {
        //   longitude =value;
        //  print(longitude);
      });
    });
  }

  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Get.lazyPut(
      () => LocationController(),
    );
    BookedServiceVM model =
        Provider.of<BookedServiceVM>(context, listen: false);
    model.clearbookedtest();

    getData();
    // venueNo=venueNo;
    // venueBranchNo= widget.ven_branch;
    // userno=widget.user_no;
    super.initState();
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    locationController.permission();

    final List<HomeGridData> listGrid = [
      HomeGridData(
          "Appointment",
          'assets/images/appointment.png',
          "Make your formal arrangement at your home,\nat your place, anywhere.",
          AppointmentView()),
      HomeGridData(
          "New Request",
          'assets/images/new_request.png',
          "Request for access to our Facilities \nand Services",
          const NewRequestView()),
      HomeGridData(
          "Samples",
          'assets/images/sample_collected.png',
          "Total number  of blood samples collected \nfrom the patients",
          const CollectedSamplesView()),
      HomeGridData(
          "History",
          'assets/images/history.png',
          "Record of information about a person’s \nhealth",
          const HistoryView()),
    ];

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: WillPopScope(
      onWillPop: () => NavigateController.disableBackBt(),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldkey,
        drawer: HomeDrawer(
          selectedScreen: 1,
          width: width,
          height: height,
        ),
        appBar: AppBar(
          backgroundColor: CustomTheme.background_green,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(19.0),
            child: InkWell(
                onTap: () {
                  scaffoldkey.currentState!.openDrawer();
                },
                child: Image.asset('assets/images/hamburger.png')),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: height * 0.22,
              child: Column(
                children: [
                  Container(
                    height: height * 0.21,
                    width: width,
                    decoration: BoxDecoration(
                        color: CustomTheme.background_green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(height * 0.3 / 15))),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: height * -0.089,
                          right: width * -0.181,
                          child: Image.asset(
                            'assets/images/hearting.png',
                            height: height * 0.28,
                            color: CustomTheme.circle_green,
                          ),
                        ),
                        Positioned(
                            top: height * 0.00,
                            left: width * 0.05,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  greeting(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 21),
                                ),
                                Text(
                                  userName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Obx(() {
                                  // if (lat == '') {
                                  // return CircularProgressIndicator();
                                  // } else {
                                  return Row(
                                    children: [
                                      Text(
                                        "Location :: ",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 21),
                                      ),
                                      Text(
                                        locationController.lat.value
                                                .toString() ??
                                            LocalDB.getLDB("location")
                                                .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 21),
                                      ),
                                    ],
                                  );
                                }),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                const Text(
                                  "Make the most of your social life with help from",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                const Text(
                                  "Our home health care service",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                // InkWell(
                                //     onTap: (){
                                //       NavigateController.pagePush(context, const NewBookingView());
                                //     },
                                //     child: SizedBox(
                                //       width: width * 0.30,
                                //        height: height * 0.1,
                                //       child: Lottie.asset('assets/images/new_appoitment.json',
                                //
                                //         fit: BoxFit.fill,),
                                //     ))
                                SizedBox(
                                    width: width * 0.35,
                                    height: height * 0.04,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff3768E1)),
                                          elevation:
                                              MaterialStateProperty.all(7)),
                                      onPressed: () {
                                        // NavigateController.pagePush(context, Appview());
                                        // NavigateController.pagePush(context,  PatientDetailsView(screenType: 1, bookingType: "BookinType", bookingID:  "Hc7u6u", data2:const {}));
                                        // NavigateController.pagePush(context, PaymentView(bookingID: "HC0767776", ScreenType: 1, bookingType:"APP"));

                                        NavigateController.pagePush(
                                            context, const NewBookingView());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/add_appointment.png',
                                            height: height * 0.018,
                                          ),
                                          SizedBox(
                                            width: width * 0.016,
                                          ),
                                          Text(
                                            'New Booking',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.026,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.59,
              child: SizedBox(
                // height: height * 0.51,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        const Text(
                          'Our Health \nService',
                          style: TextStyle(
                              color: Color(0xff182893),
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        // Image.asset('assets/images/hamburger.png',height: height * 0.02,color: Colors.grey[300],),
                        SizedBox(
                          width: width * 0.05,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: listGrid.length,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                highlightColor: Colors.white,
                                onTap: () {
                                  NavigateController.pagePush(
                                      context, listGrid[index].screen);
                                },
                                child: SizedBox(
                                  height: height * 0.12,
                                  width: width * 0.9,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.038,
                                          ),
                                          Container(
                                            height: height * 0.09,
                                            width: width * 0.19,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Center(
                                                  child: Image.asset(
                                                listGrid[index].assets,
                                                color: CustomTheme
                                                    .background_green,
                                              )),
                                            ),
                                          ),
                                          // SizedBox(width: width * 0.001,),
                                          SizedBox(
                                            height: height * 0.09,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Text(
                                                  listGrid[index].title,
                                                  style: const TextStyle(
                                                      color: Color(0xff4662AC),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(height: height * 0.01),
                                                Text(
                                                  listGrid[index].description,
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      // const Spacer(),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.21,
                                          ),
                                          SizedBox(
                                              width: width * 0.63,
                                              child: const Divider(
                                                  color: Colors.black26,
                                                  thickness: 1)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

class HomeGridData {
  final String title;
  final String assets;
  final String description;
  final Widget screen;

  HomeGridData(this.title, this.assets, this.description, this.screen);
}
