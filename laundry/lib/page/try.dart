import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> navBarItem = [
    "Kilo",
    "Blanket",
    "Bed Cover",
    "T-Shirt",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Dashboard')),
      backgroundColor: Color(0xffF3F2F8),
      // body: Center(
      //   child: Text('Dashboard Screen', style: TextStyle(fontSize: 40)),
      // ),
      body: Container(
        height: 125,
        child: Column(
        children: <Widget>[
        SizedBox(height: 20,),
        Center(child: new Text("Package List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black.withOpacity(1.0)),)),
        SizedBox(height: 20,),
        Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: navBarItem.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print(navBarItem[index]);
              },
              child: Container(
                // height: 10,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                    color: Color(0xff312879),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  navBarItem[index],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            );
          },
          ),
          ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {} ,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      //   backgroundColor: Color(0xff312879),
      // ),
    );
  }
}