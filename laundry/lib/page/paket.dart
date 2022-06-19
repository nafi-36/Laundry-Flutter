import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/home.dart';
import 'package:laundry/page/AddPaket.dart';
import 'package:laundry/page/editPaket.dart';
import 'dart:async';
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

class Paket extends StatefulWidget {
  String category;
  String category_name;
  Paket({required this.category, required this.category_name});
  // debugPrint(this.category);

  @override
  _PaketState createState() => _PaketState();
}

class _PaketState extends State<Paket> {
  Future<List> getData() async {
    var url = "http://localhost:8080/paket/byCategory/${widget.category}";

    final response = await http.get(Uri.parse(url));
    // final "[" + response.body + "]";
    setState(() {});
    // debugPrint(response.body);
    return json.decode(response.body);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laundry Categories ${widget.category_name}',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black.withOpacity(1.0),
              fontWeight: FontWeight.w900),
        ),
        leading: new IconButton(
    icon: new Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    },
  ),
        toolbarHeight: 90,
        centerTitle: true,
        shadowColor: Color(0xffF3F2F8),
        elevation: 0.0,
        bottomOpacity: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: const <Widget>[
          Icon(
            Icons.more_vert_outlined,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.0),
          ),
        ],
        backgroundColor: Color(0xffF3F2F8),
      ),
      backgroundColor: Color(0xffF3F2F8),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          // onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          //   builder: (BuildContext context) => new AddData(),
          // )),
          backgroundColor: Color(0xff312879),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                       AddPaket()));
          }),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top: 40),
              margin: EdgeInsets.only(
                right: 18.0,
                left: 18.0,
              ),

              height: 65,
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
                                // width: 110,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                // widget.category == category[index] ? 
                                decoration: BoxDecoration(
                                  color: Color(0xff312879),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:  Center(child: Text(categoryItem[index], style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),)),
                              ));
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              // margin: EdgeInsets.only(top: 40),
              height: 711,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder<List>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData
                            ? ItemList(
                                list: snapshot.data ?? [],
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                                // child: CircularProgressIndicator(),

                              );
                            
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});

  deleteData(int id) async {
    var url = "http://localhost:8080/paket/${id}";
    http.delete(Uri.parse(url));
    int value = 0;
  }

  confirm(BuildContext context, int id, String nama_paket) {
    Alert(
      context: context,
      content: Text(
        "Are You sure want to delete '${nama_paket}'?",
        style: new TextStyle(color: Colors.black, fontSize: 13),
        textAlign: TextAlign.center,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          color: Color(0xff312879),
          onPressed: () {
            deleteData(id);

            Navigator.pop(context);
          },
        ),
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ).show();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          // height: 150,
          // padding: const EdgeInsets.all(10.0),
          margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),

          child: AspectRatio(
            aspectRatio: 3 / 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  //background color of box
                  BoxShadow(
                    color: Color(0xff393939).withOpacity(0.03),
                    blurRadius: 60.0, // soften the shadow
                    spreadRadius: 2.0, //extend the shadow
                    offset: Offset(
                      10.0, // Move to right 10  horizontally
                      6.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              // margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: <Widget>[
                  // Padding(padding: EdgeInsets.only(left: 10)),
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        list[i]['image'],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            list[i]['nama_paket'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            list[i]['jenis'],
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Rp. " + list[i]['harga'].toString() + ",-",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Color(0xff312879),
                   onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new EditPaket(
                      list: list,
                      index: i,
                    ))),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Color(0xff312879),
                    onPressed: () {
                      confirm(
                          context, list[i]['id_paket'], list[i]['nama_paket']);
                    },
                  ),
                ],
              ),
              // child: ListTile(
              //   title: Text(list[i]['nama_paket'],
              //       style:
              //           TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              //   leading: Image.asset(
              //     "http://localhost:8080/image/paket/" + list[i]['image'],
              //     width: 200,
              //     height: 100,
              //   ),
              // ),
            ),
          ),
        );
      },
    );
  }

  // confirm(BuildContext context, list, list2) {}
}
