import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hrms_app/Components/custom_icons.dart';
import 'package:hrms_app/Components/custom_text.dart';
import 'package:hrms_app/Constants/constants.dart';
import 'package:hrms_app/RestAPI/rest_api.dart';
import 'package:hrms_app/model/my_holidays/my_holidays_response_model.dart';
import 'package:hrms_app/models_providers/theme_provider.dart';
// import 'package:hrms_app/utils/strings.dart';
import 'package:provider/provider.dart';
import  'package:intl/intl.dart';

class MyHolidays3 extends StatefulWidget {
  String? apiKey;


  MyHolidays3({this.apiKey});

  @override
  _MyHolidaysState createState() => _MyHolidaysState();
}

class _MyHolidaysState extends State<MyHolidays3> {
  //String APIKey = "";
  late List<MyHolidayModel> list;
  late Size size;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    size = MediaQuery.of(context).size;
    bool isLightTheme = themeProvider.isLightTheme;

    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          primary: true,
          title: customToolBar(size, backButtonImagePath, "My Holidays",
              isLightTheme ? true : false),
          automaticallyImplyLeading: false,
          backgroundColor:
              isLightTheme ? l_toolbar_bg_color : d_toolbar_bg_color,
          shadowColor: Colors.transparent,
          titleSpacing: 0.9,
        ),
        // body: Container()

      body: _buildBody(context,widget.apiKey!),
    );
  }



  //build list view & manage states
  FutureBuilder<MyHolidaysResponseModel> _buildBody(BuildContext context,String apikey ) {
    // final client =
    // ApiClientNew(Dio(BaseOptions(contentType: "application/json")));

    RestApi restApi = new RestApi();

    return FutureBuilder<MyHolidaysResponseModel>(
      future: restApi.getMyHolidaysApiCall(apikey),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          EasyLoading.dismiss();
          final List<MyHolidayModel> posts = snapshot.data!.myHolidays!;


          List<MyHolidayListModel> holidayList=[];

          for(int i=0; i<posts.length;i++){
            // DateTime dateTime=DateFormat.yMd('en_US').parse('1/10/2012');
            //DateTime dateTime=DateFormat.yMd('en_US').parse(posts[i].date);


            // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

            DateFormat dateFormat = DateFormat("MM/dd/yyyy");

            DateTime dateTime = dateFormat.parse(posts[i].date!);
            // DateFormat('EEEE').format(dateTime);

            // posts[i].date=dateTime.day.toString();
            // print(DateFormat('EEEE').format(date)); // prints Tuesday
            // print(DateFormat('EEEE, d MMM, yyyy').format(date)); // prints Tuesday, 10 Dec, 2019
            // print(DateFormat('h:mm a').format(date));


            String dayName=DateFormat('EEEE').format(dateTime);
            String day=DateFormat('dd').format(dateTime);
            String monthName=DateFormat('MMMM').format(dateTime);
            String year=DateFormat('yyyy').format(dateTime);

            holidayList.add(new MyHolidayListModel(title: posts[i].title,dayname: dayName,day: day,monthname: monthName,year: year));

            //posts[i].date=day_name+"-"+day+"-"+month_name+"-"+year;
          }

          return _buildListView(context, holidayList,size);
          // return _buildListView(context, posts);
          //return Container();
        } else {
          return Center(
            // child: CircularProgressIndicator(),
            child: CustomProgressBar(),
          );
        }
      },
    );
  }


  // ignore: non_constant_identifier_names
  Widget CustomProgressBar(){
    EasyLoading.show();
    return Container();
  }


  Widget _buildListView(BuildContext context, List<MyHolidayListModel> posts,Size size) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 3, left: 3.0, right: 3,bottom: 3),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: size.height * 0.1,
                  // width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: darkModeColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CustomText(
                      //   text: "Thursday",
                      //   color: white,
                      // ),
                      CustomText(
                        text: posts[index].day,
                        color: orange,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: posts[index].monthname,
                        color: white,
                        size: 14,
                      ),
                      CustomText(
                        text: posts[index].year,
                        color: white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: size.height * 0.1,
                  // width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        topLeft: Radius.circular(12),
                      ),
                      color: darkModeColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: CustomText(
                              text: posts[index].dayname,
                              color: green,
                              size: 18,
                              weight: FontWeight.bold,
                            )),

                        customFixedHeightSizedBox(size),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomIcon(icon: Icons.calendar_today_rounded,),
                              customFixedWidthSizedBox(size),
                              CustomText(
                                text: posts[index].title,
                                color: orange,
                                size: 16,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: posts.length,
    );
  }
}
