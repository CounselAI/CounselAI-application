import 'package:counselaicompanion/frontend/screens/signup_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'saved_cases_list.dart';
import 'archived_cases_list.dart';
import 'package:counselaicompanion/frontend/utils/color_utils.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import '/frontend/screens/profile_page.dart';

class HomePage extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final title = "Your Personal Law Assistant";
  HomePage({key, title}) : super(key: key);
  //URL LaunchInBrowser Functionality

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24.5, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black,
          toolbarHeight: 80,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.book,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          stops: const [0.5, 1.0],
                          colors: [
                            hexStringToColor("#FFD700"),
                            hexStringToColor("#00000"),
                          ],
                        )),
                    child: const Text(
                      "Options",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.7,
                    ),
                  )),
              Image.asset('assets/images/logo.png', width: 200, height: 200),
              ListTile(
                title: const Text("Log Out", style: TextStyle(fontSize: 18)),
                onTap: () async {
                  final SharedPreferences prefs = await _prefs;
                  prefs.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ));

                  // Get.off(const SignUpScreen());
                },
              ),
              ListTile(
                title: const Text("Visit The Website",
                    style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black87,
              actions: const <Widget>[],
              title: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.greenAccent),
                tabs: const [
                  Tab(
                      icon: Icon(Icons.document_scanner_outlined,
                          size: 33, color: Colors.white)),
                  Tab(icon: Icon(Icons.storage, size: 33, color: Colors.white)),
                  Tab(icon: Icon(Icons.person, size: 33, color: Colors.white)),
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body: TabBarView(
              //children: <Widget>[...] for many images
              children: [
                ListView(
                  children: const <Widget>[
                    SavedCasesList(),
                  ],
                ),
                // const Icon(
                //   Icons.people_alt_outlined,
                //   size: 55.0,
                // ),
                ListView(
                  children: const <Widget>[
                    ArchivedCasesList(),
                  ],
                ),
                const ProfilePage()
                // const Icon(
                //   Icons.person,
                //   size: 250.0,
                // ),
                //Icon(Icons.directions_bike,size: 55.0,),
              ],
            ),
          ),
        ));
  }
}
