import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/home.dart';
import 'package:laundry/page/dashboard.dart';
import 'package:laundry/page/detailOutlet.dart';

class EditOutlet extends StatefulWidget {
  // const EditOutlet({Key? key}) : super(key: key);

  final List list;
  final int index;

  EditOutlet({required this.list, required this.index});

  @override
  _EditMemberState createState() => _EditMemberState();
}

class _EditMemberState extends State<EditOutlet> {
  late TextEditingController controllerNama_outlet;
  late TextEditingController controllerAlamat;
  // late TextEditingController controllerGender;
  late TextEditingController controllerTlp;

  // String _value = 'null';
  // List<ListItem> _dropdownItems = [
  //   ListItem('null', "Select Gender"),
  //   ListItem('P', "Female"),
  //   ListItem('L', "Male"),
  // ];

  void EditOutlet() {
    var url =
        "http://localhost:8080/outlet/${widget.list[widget.index]['id_outlet']}";
    http.put(Uri.parse(url), body: {
      "nama_outlet": controllerNama_outlet.text,
      "alamat": controllerAlamat.text,
      "tlp": controllerTlp.text,
    });
  }

  @override
  void initState() {
    controllerNama_outlet = new TextEditingController(
        text: widget.list[widget.index]['nama_outlet']);
    controllerAlamat =
        new TextEditingController(text: widget.list[widget.index]['alamat']);
    controllerTlp =
        new TextEditingController(text: widget.list[widget.index]['tlp']);
    super.initState();
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
        padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Edit Outlet',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(1.0)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Fill the form below!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5)),
            ),
            SizedBox(height: 50),
            Column(
              children: [
                TextField(
                    controller: controllerNama_outlet,
                    decoration: InputDecoration(
                      fillColor: Color(0xffF1F0F5),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Color(0xff312879), width: 1.5),
                      ),
                      hintText: "Enter outlet's name",
                      floatingLabelStyle: const TextStyle(
                          color: Color(0xff312879),
                          fontWeight: FontWeight.w600),
                      labelText: "Name",
                    )),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  // focusNode: _focusNode,
                  controller: controllerAlamat,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Color(0xff312879), width: 1.5),
                    ),
                    hintText: "Enter outlet's address",
                    floatingLabelStyle: const TextStyle(
                        color: Color(0xff312879), fontWeight: FontWeight.w600),
                    labelText: "Address",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // TextField(
                //   // focusNode: _focusNode,
                //   controller: controllerGender,
                //   decoration: InputDecoration(
                //     fillColor: Color(0xffF1F0F5),
                //     filled: true,
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //       borderSide: BorderSide(),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //       borderSide:
                //           BorderSide(color: Color(0xff312879), width: 1.5),
                //     ),
                //     hintText: "Enter customer's gender",
                //     floatingLabelStyle: const TextStyle(
                //         color: Color(0xff312879), fontWeight: FontWeight.w600),
                //     labelText: "Gender",
                //   ),
                // ),

                TextField(
                  // focusNode: _focusNode,
                  controller: controllerTlp,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Color(0xff312879), width: 1.5),
                    ),
                    hintText: "Enter outlet's phone",
                    floatingLabelStyle: const TextStyle(
                        color: Color(0xff312879), fontWeight: FontWeight.w600),
                    labelText: "Phone",
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(children: [
                  // SizedBox(width: 10,),
                  Container(
                    width: 333,
                    height: 45,
                    child: ElevatedButton(
                      child: Text("SAVE",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff312879)),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: Color(0xff312879))))),
                      onPressed: () {
                        EditOutlet();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                      
                                    ))).then((value) => setState(() {}));
                      },
                      // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new Home()));
                    ),
                  ),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}

//  https://codesinsider.com/flutter-dropdown-button-example/#:~:text=Dropdown%20button%20is%20a%20material,user%20can%20select%20another%20item.
