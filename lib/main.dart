import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';

import 'package:hrms_app/pages/Login/login.dart';
// import 'package:hrms_app/pages/My%20Attendance/My%20Attendance.dart';
// import 'package:hrms_app/pages/My%20Holidays/my_holidays.dart';
import 'animation/custom_animation.dart';


import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

import 'models_providers/theme_provider.dart';

// void main() {
//   runApp(new MaterialApp(home: new Expandable()));
// }
//
// class Expandable extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: new AppBar(
//         title: new Text("Expandable List"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: new ListView.builder(
//         itemBuilder: (BuildContext context, int index) {
//           return new ExpandableClass(title: "Title $index");
//         },
//         itemCount: 5,
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  print(isLightTheme);

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: AppStart(),
  ));

  configLoading();
}

// to ensure we have the themeProvider before the app starts lets make a few more changes.

class AppStart extends StatelessWidget {
  const AppStart({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(
      themeProvider: themeProvider,
    );
  }
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider? themeProvider;

  const MyApp({Key? key,  this.themeProvider}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Light Dark Theme',
      theme: widget.themeProvider!.themeData(),

      builder: EasyLoading.init(),



        home: Login(),
      //home: MenuDashboardPage(),
      //home: MyAttendance(),
      //home: APICall(),
      //home: ForgotPassword(),
      //home: MyHolidays3(),
    );

    // return new Scaffold(
    //   backgroundColor: Colors.grey,
    //   appBar: new AppBar(
    //     title: new Text("Expandable List"),
    //     backgroundColor: Colors.redAccent,
    //   ),
    //   body: new ListView.builder(
    //     itemBuilder: (BuildContext context, int index) {
    //       return new ExpandableClass(title: "Title $index");
    //     },
    //     itemCount: 5,
    //   ),
    // );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..customAnimation = CustomAnimation();
}

// Theme Data is saved on refresh or restart
// App bar color also changes with theme
