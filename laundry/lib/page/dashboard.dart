import 'package:flutter/material.dart';
import 'package:laundry/page/addOutlet.dart';
import 'package:laundry/page/detailOutlet.dart';
import 'package:laundry/page/member.dart';
import 'package:laundry/page/paket.dart';
import 'package:laundry/page/profile.dart';
import 'admin.dart';
import 'package:laundry/home.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class OutletModel {
  String id_outlet;
  // String createdOn;
  // String lastModifiedOn;
  String nama_outlet;
  String alamat;
  String tlp;

  OutletModel(
      {required this.id_outlet,
      required this.nama_outlet,
      required this.tlp,
      required this.alamat});
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> screens = [Dashboard(), Admin(), Member(), Profile()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  List<String> categoryItem = [
    "Kilo",
    "Blanket",
    "Bed Cover",
    "T-Shirt",
    "Others"
  ];

  List<String> category = ["kilo", "blanket", "bed_cover", "t-shirt", "others"];

  List<String> categoryImage = [
    "kilo.png",
    "blanket.png",
    "bedcover.png",
    "tshirt.png",
    "others.png"
  ];

  List<String> outletList = ["Ezy outlet 1", "Ezy Outlet 2", "Ezy Outlet 3"];

  List<String> outletAddress = [
    "Jl Kauman Rahaja No.21, Klojen, Malang",
    "Jl Pangeran Sudirman No.07, Jakarta Timur",
    "Jl Soekarno Hattna No.66, Surabaya Timur"
  ];

  int b = 1;
  int a = 0;

  int c = 0;

  Future<List> getOutlet() async {
    var url = "http://localhost:8080/outlet/";

    final response = await http.get(Uri.parse(url));
    // final "[" + response.body + "]";
    // debugPrint(response.body);
    setState(() {
      
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Profile')),
      backgroundColor: Color(0xffF3F2F8),

      body: Container(
        margin: EdgeInsets.only(right: 25.0, left: 25.0, top: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 35, // Image radius
              backgroundImage: AssetImage("/profile1.jpeg"),
            ),
            SizedBox(height: 15),
            new Text("Laura Shanon",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            SizedBox(height: 10),
            new Text("Welcome back",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black.withOpacity(1.0))),
            SizedBox(height: 30),
            new Text("Category",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 20),
            Container(
              // margin: EdgeInsets.only(top: 40),
              height: 140,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryItem.length,
                        itemBuilder: (context, index) {
                          // print(a);
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => Paket(
                                          category: category[index],
                                          category_name: categoryItem[index],
                                        )));
                              },
                              child: Container(
                                width: 110,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // boxShadow: [
                                  //   //background color of box
                                  //   BoxShadow(
                                  //     color:
                                  //         Color(0xff393939).withOpacity(0.03),
                                  //     blurRadius: 60.0, // soften the shadow
                                  //     spreadRadius: 2.0, //extend the shadow
                                  //     offset: Offset(
                                  //       2.0, // Move to right 10  horizontally
                                  //       1.0, // Move to bottom 10 Vertically
                                  //     ),
                                  //   )
                                  // ],
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 15),
                                      Image.asset(
                                        categoryImage[index],
                                        width: 45,
                                        height: 45,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        categoryItem[index],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // new Text("Outlet",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Outlet",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Padding(
                    padding: EdgeInsets.only(left: 200),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Text("+ Add Data", style: TextStyle(fontSize: 15),),
                          ElevatedButton(
                            child: Text("+ Add Outlet",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff312879)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: Color(0xff312879))))),
                            onPressed: () {
                              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new AddOutlet()),
              );
                            },
                          ),
                        ])) 
              ],
            ),
            SizedBox(height: 20),
            Container(
              // margin: EdgeInsets.only(top: 40),
              height: 330,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder<List>(
                      future: getOutlet(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        return snapshot.hasData
                            ? ItemList(
                                list: snapshot.data ?? [],
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                  // Expanded(child:
                  //   RaisedButton(
                  //   child: Text("data"),
                  //   onPressed: (){})
                  // )
                  // RaisedButton(
                  //   child: Text("data"),
                  //   onPressed: (){})
                ],
              ),
            ),
          ],
        ),
      ),
      // Home();
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new DetailOutlet(
                          list: list,
                          index: i,
                        )),
              );
            },
            child: Container(
              width: 250,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              // child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "/bluOutlet.png",
                    width: 400,
                    // height: 100,
                  ),
                  SizedBox(height: 12),
                  Text(
                    list[i]['nama_outlet'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(1.0)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    list[i]['alamat'],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              // ),
            ));
      },
    );
  }
}
