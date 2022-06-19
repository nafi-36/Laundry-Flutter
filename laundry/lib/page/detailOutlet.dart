import 'package:flutter/material.dart';
import 'package:laundry/home.dart';
import 'package:laundry/page/editOutlet.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class DetailOutlet extends StatefulWidget {
  List list;
  int index;
  DetailOutlet({required this.index, required this.list});
  
  @override
  _DetailOutletState createState() => _DetailOutletState();
}

class _DetailOutletState extends State<DetailOutlet> {
  deleteData(int id) async {
    var url = "http://localhost:8080/outlet/${id}";
    http.delete(Uri.parse(url));
    
    int value = 0;
  }

  

  confirm(BuildContext context, int id, String nama_outlet) {
    Alert(
      context: context,
      content: Text(
        "Are You sure want to delete '${nama_outlet}'?",
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()))
            .then((value) => setState(() {}));
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        shadowColor: Color(0xffF3F2F8),
        elevation: 0.0,
        bottomOpacity: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffF3F2F8),
      ),
      backgroundColor: Color(0xffF3F2F8),
      body: Container(
        child: Container(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "/outletIllus.png",
              width: 300,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 800,
              height: 329,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
              ),
              child: Container(
                margin: EdgeInsets.only(right: 45.0, left: 45.0, top: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.list[widget.index]['nama_outlet'],
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black.withOpacity(1.0))),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Ezy Laundry Outlet"),
                    SizedBox(
                      height: 25,
                    ),
                    Text("Telephone",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff312879).withOpacity(1.0))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.list[widget.index]['tlp']),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Address",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff312879).withOpacity(1.0))),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.list[widget.index]['alamat']),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // alignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 162,
                          height: 45,
                          child: ElevatedButton(
                            child: Text("EDIT",
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
                    builder: (context) => new EditOutlet(
                          list: widget.list,
                          index: widget.index,
                        )),
              );
                            },
                          ),
                          padding: EdgeInsets.only(right: 12),
                        ),
                        Container(
                          width: 162,
                          height: 45,
                          child: OutlinedButton(
                              child: Text("DELETE",
                                  style: TextStyle(
                                      color: Color(0xff312879),
                                      fontWeight: FontWeight.w600)),
                              // textColor: Colors.white,
                              // color: Color(0xff312879),
                              onPressed: () {
                                confirm(
                                    context,
                                    widget.list[widget.index]['id_outlet'],
                                    widget.list[widget.index]['nama_outlet']);
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                side: BorderSide(
                                    width: 1.5, color: Color(0xff312879)),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
