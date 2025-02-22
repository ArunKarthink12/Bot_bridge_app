import 'package:botbridge_green/Utils/NavigateController.dart';
import 'package:botbridge_green/View/AddToCartView.dart';
import 'package:botbridge_green/View/Helper/ThemeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/BookedServiceVM.dart';
import '../ViewModel/ServiceDetailsVM.dart';
import 'ServicesView.dart';

int cartCount = 2;
class SearchTests extends StatefulWidget {
  final String referalID;
  final String BookingID;
  final String bookingType;
    final String regdate;

  const SearchTests({Key? key, required this.BookingID, required this.referalID, required this.bookingType, required this.regdate}) : super(key: key);

  @override
  _SearchTestsState createState() => _SearchTestsState();
}

class _SearchTestsState extends State<SearchTests> with TickerProviderStateMixin  {
  int selectedItem = 0;
  String searchtxt = "";

  final TextEditingController searchtestController = TextEditingController();

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    tabController.addListener(handleTabSelection);

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchtestController.dispose();
    super.dispose();
  }

  handleTabSelection() {
    setState(() {
      selectedItem = tabController.index;
      searchtxt = searchtestController.text;
    });
    ServiceDetailsVM model =
    Provider.of<ServiceDetailsVM>(context, listen: true);

    model.setsearch_name(searchtestController.text);
    model.setsearch_key("$tabController.index");
  }


  @override
  Widget build(BuildContext context) {
    BookedServiceVM testCount = Provider.of<BookedServiceVM>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
           backgroundColor: CustomTheme.circle_green,
            body:Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        widget.bookingType=="NewBooking"?
                        Navigator.pop(context):
                        NavigateController.pagePush(context, AddToCartView(bookingType: widget.bookingType, bookID: widget.BookingID, regdate: widget.regdate,));
                      }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                      SizedBox(
                        height: height * 0.06,
                        width: width * 0.7,
                        child: TextFormField(
                          controller: searchtestController,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          onChanged: (value) {
                              final ServiceDetailsVM api = ServiceDetailsVM();
                              ServiceDetailsVM model =
                              Provider.of<ServiceDetailsVM>(context, listen: false);

                              Map<String, dynamic> params = {
      "servicetype": '',//widget.serviceType,
      "serviceName": searchtestController.text,//widget.searchkey,
      "clientNo": 0,
      "physicianNo": 0,
      "pageIndex": 1,
        "venueNo": 1,
  "venueBranchNo": 1, //model.nextPage
    };
                              if (widget.referalID.isNotEmpty) {
                                // params["CustomerID"] = widget.referalID;
                              }

                              api.fetchServiceDetails(params, model,searchtestController.text);



                            // ServicesListView(serviceType: '', BookingID: widget.BookingID, refID: widget.referalID, bookingType: widget.bookingType,searchkey:searchtestController.text);
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(color: Colors.white,width: 1)
                              ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.white,width: 1)
                            ),
                            suffixIcon: const Icon(Icons.search_sharp,size: 16,color: Colors.white,),
                            hintText: "Search",
                            contentPadding: const EdgeInsets.only(top: 3,left: 10),
                            hintStyle: const TextStyle(color: Colors.white,fontSize: 12)
                          ),
                        ),
                      ), const Spacer(),
                    
                    const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                 TabBar(
                   controller: tabController,
                  
                   splashBorderRadius: BorderRadius.circular(10),
                     overlayColor: MaterialStateProperty.resolveWith<Color?>(
                           (Set<MaterialState> states) {
                         if (states.contains(MaterialState.hovered)) {
                           return Colors.white;
                         } //<-- SEE HERE
                         return null;
                       },
                     ),
                     onTap: (int index) {
                       setState(() {
                         selectedItem = index;
                         searchtestController.clear();
                       });
                     },
                     indicatorColor:Colors.transparent,
                     indicatorWeight: 1,
                     labelColor: CustomTheme.background_green,
                     labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                     unselectedLabelColor:Colors.white ,
                     unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                     tabs: [
                   tabContainer("All",0 == selectedItem),
                   tabContainer("PRO",1 == selectedItem),
                   tabContainer("TEST",2 == selectedItem),
                   tabContainer("GRP",3 == selectedItem),
                ]),
                const SizedBox(height: 20,),
                 Expanded(
                  child:  TabBarView(
                    controller: tabController,
                      children: [
                        ServicesListView(serviceType: '', BookingID: widget.BookingID, refID: widget.referalID, bookingType: widget.bookingType,searchkey:searchtestController.text),
                        ServicesListView(serviceType: "P", BookingID: widget.BookingID, refID:widget.referalID, bookingType: widget.bookingType,searchkey:searchtestController.text),
                        ServicesListView(serviceType: 'T', BookingID: widget.BookingID, refID:widget.referalID, bookingType: widget.bookingType,searchkey:searchtestController.text),
                        ServicesListView(serviceType: 'G', BookingID: widget.BookingID, refID: widget.referalID, bookingType: widget.bookingType,searchkey:searchtestController.text)
                  ]),
                )
              ],
            ) ,
    ),
        )
    );
  }
  Widget tabContainer(String name,bool con){
    return Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
            color:con ? Colors.white : CustomTheme.circle_green,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: con ?[
            const BoxShadow(
              color: Colors.black12,
              offset: Offset(1,4),
              blurRadius: 5
            )
          ] : null
        ),
        child: Tab(child: Text(name,style: TextStyle(color: con ? CustomTheme.background_green  : Colors.white ),),)
    );
  }
}
