
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'page/dashboard.dart';
import 'page/admin.dart';
import 'page/member.dart';
import 'page/profile.dart';
import 'page/app.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [Dashboard(), Admin(), Member(), Profile(), App()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),


      bottomNavigationBar: Container(

        color: Color(0xffF3F2F8),

        child: Container(

          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15,
          ),
          decoration: new BoxDecoration(
              color: Color(0xff312879),
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0),
              )
            ),
          
         
          
          child: GNav( 
            gap: 20,
            // backgroundColor: Color(0xff312879),
            color: Colors.white,
            iconSize: 30,
            activeColor: Colors.white,
            // tabBackgroundColor: Colors.white.withOpacity(0.5),
            tabActiveBorder: Border.all(color: Colors.white, width: 1),
            
           
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
                onPressed: () {
                    setState(() {
                      currentScreen = Dashboard();
                      currentTab = 0;
                    });
                }
              ),
              GButton(
                icon: Icons.person_pin_sharp, 
                text: "Admin",
                onPressed: () {
                    setState(() {
                      currentScreen = Admin();
                      currentTab = 1;
                    });
                }
              ),
              GButton(
                icon: Icons.people,
                text: "Customer",
                onPressed: () {
                    setState(() {
                      currentScreen = Member();
                      currentTab = 2;
                    });
                }
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
                 onPressed: () {
                    setState(() {
                      currentScreen = Profile();
                      currentTab = 3;
                    });
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}