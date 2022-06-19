import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/home.dart';
import 'package:laundry/page/addMember.dart';
import 'package:laundry/page/editMember.dart';
import 'dart:async';
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';

class Member extends StatefulWidget {
  const Member({Key? key}) : super(key: key);

  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  Future<List> getMember() async {
    var url = "http://localhost:8080/member";

    final response = await http.get(Uri.parse(url));
    // final "[" + response.body + "]";
    setState(() {});
    // debugPrint(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer List',
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
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          // onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          //   builder: (BuildContext context) => new AddData(),
          // )),
          backgroundColor: Color(0xff312879),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                       AddMember()));
          }),
      body: new FutureBuilder<List>(
        future: getMember(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data ?? [],
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});
  int a = 0;

  deleteData(int id) async {
    var url = "http://localhost:8080/member/${id}";
    http.delete(Uri.parse(url));
    int value = 0;
  }

  confirm(BuildContext context, int id, String nama) {
    Alert(
      context: context,
      content: Text(
        "Are You sure want to delete customer '${nama}'?",
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
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        a++;
        return new Container(
          height: 100,
          // padding: const EdgeInsets.only(right: 10.0, left: 10, top: 10, bottom: 10),
          // child: new GestureDetector(
          // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
          //     builder: (BuildContext context) => new Detail(
          //           list: list,
          //           index: i,
          //         ))),
          margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),

          child: new Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                // side: BorderSide(color: appThemeColor.shade200, width: 0.5),
                borderRadius: BorderRadius.circular(15)),
            child: new ListTile(
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              // selected: true,
              // ignore: prefer_const_constructors
              // contentPadding: EdgeInsets.all(10),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 13, horizontal: 15),
              leading: CircleAvatar(
                child: Text(
                  a.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                backgroundColor: Color(0xff312879),
              ),
              title: new Text(list[i]['nama'],
                  style:
                      new TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              // leading: Image.network(list[i]['username'], width: 50, height: 100,),
              subtitle: new Text(list[i]['alamat'],
                  style:
                      new TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Color(0xff312879),
                    onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new EditMember(
                      list: list,
                      index: i,
                    ))),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Color(0xff312879),
                    onPressed: () {
                      confirm(
                          context, list[i]['id_member'], list[i]['nama']);
                    },
                  ),
                ],
              ),
            ),
          ),
          //   ),
        );
      },
    );
  }
}
