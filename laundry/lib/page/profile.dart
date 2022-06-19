import 'package:flutter/material.dart';
import 'package:laundry/page/admin.dart';
import 'package:laundry/page/splash.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black.withOpacity(1.0),
              fontWeight: FontWeight.w900),
        ),
        toolbarHeight: 90,
        centerTitle: true,
        shadowColor: Color(0xffF3F2F8),
        elevation: 0.0,
        bottomOpacity: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffF3F2F8),
      ),
      backgroundColor: Color(0xffF3F2F8),
      body: Stack(alignment: Alignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("/profile1.jpeg"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: Container(
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Laura Shanon",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              // SizedBox(height: 5,),
                              Text("admin - Ezy Laundry 02"),
                              // SizedBox(height: 5,),
                              Container(
                                height: 32,
                                width: 90,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    side: BorderSide(
                                        width: 1.5, color: Color(0xff312879)),
                                  ),
                                  child: Text(
                                    "admin".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xff312879), fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            // Expanded(
            // flex: 4,
            Container(
              height: 550,
              width: 800,
              margin: EdgeInsets.only(right: 20, left: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          right: 35.0,
                          left: 35.0,
                        ),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      leading: Icon(
                        Icons.person,
                        color: Color(0xff312879),
                      ),
                      title: new Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          right: 35.0,
                          left: 35.0,
                        ),
                        child: Text(
                          "My Outlet",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      leading: Icon(Icons.store, color: Color(0xff312879)),
                      title: new Text("Outlet Detail",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      leading: Icon(Icons.print, color: Color(0xff312879)),
                      title: new Text("Report",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          right: 35.0,
                          left: 35.0,
                        ),
                        child: Text(
                          "Security",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      leading:
                          Icon(Icons.lock_person, color: Color(0xff312879)),
                      title: new Text("Change Password",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          right: 35.0,
                          left: 35.0,
                        ),
                        child: Text(
                          "General",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      leading: Icon(Icons.settings, color: Color(0xff312879)),
                      title: new Text("Setting",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      leading: Icon(Icons.help, color: Color(0xff312879)),
                      title: new Text("Help",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 30),
                      leading: Icon(Icons.logout, color: Color(0xff312879)),
                      title: new Text("Log Out",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600)),
                     onTap: (){
                      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new Splash()),
              );
                     },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        )
      ]),
    );
  }
}
