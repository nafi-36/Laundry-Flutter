import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditAdmin extends StatefulWidget {
  // const EditAdmin({Key? key}) : super(key: key);

  final List list;
  final int index;

  EditAdmin({required this.list, required this.index});

  @override
  _EditAdminState createState() => _EditAdminState();
}

class ListItem {
  String value;
  String name;
  ListItem(this.value, this.name);
}

class _EditAdminState extends State<EditAdmin> {
  late TextEditingController controllerName;
  late TextEditingController controllerUsername;
  late TextEditingController controllerPassword;

  String? dropdownValue;

  List<ListItem> _dropdownItems = [
    // ListItem('null', "Select Role"),
    ListItem('admin', "Admin"),
    ListItem('kasir', "cashier"),
    ListItem('owner', "owner")
  ];

  int? _value;

  List data = [];

  void EditAdmin() {
    var url =
        "http://localhost:8080/user/${widget.list[widget.index]['id_user']}";
    http.put(Uri.parse(url), body: {
      "nama": controllerName.text,
      "username": controllerUsername.text,
      "id_outlet": _value.toString(),
      // "password": controllerPassword.text,
      "role": dropdownValue.toString()
    });
  }

  Future getOutlet() async {
    var url = "http://localhost:8080/outlet/";

    var response = await http.get(Uri.parse(url));
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    // final "[" + response.body + "]";
    // debugPrint(response.body);
    setState(() {
      data = jsonData;
    });
    // print(data);
    return "success";
    // return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getOutlet();
    controllerName = new TextEditingController(text: widget.list[widget.index]['nama']);
    controllerUsername = new TextEditingController(text: widget.list[widget.index]['username']);
    _value = widget.list[widget.index]['id_outlet'];
    dropdownValue = widget.list[widget.index]['role'];
    // controllerPassword = new TextEditingController(text: widget.list[widget.index]['password']);
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
              'Edit Admin',
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
                    controller: controllerName,
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
                      hintText: "Enter admin's name",
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
                  controller: controllerUsername,
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
                    hintText: "Enter admin's username",
                    floatingLabelStyle: const TextStyle(
                        color: Color(0xff312879), fontWeight: FontWeight.w600),
                    labelText: "Username",
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                  ),
                  child: DropdownButton(
                    value: _value,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    // style: const TextStyle(color: Color(0xff312879)),
                    isExpanded: true,
                    hint: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Select Outlet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    items: data.map((list) {
                      return DropdownMenuItem<int>(
                        child: Text(list['nama_outlet']),
                        value: list['id_outlet'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _value = value as int;
                      });
                      print(_value);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1),
                  ),
                  child: DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    // style: const TextStyle(color: Color(0xff312879)),
                    isExpanded: true,
                    hint: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Select Role",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    items: _dropdownItems.map((ListItem item) {
                      return DropdownMenuItem<String>(
                        child: Text(item.name),
                        value: item.value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value.toString();
                      });
                      print(dropdownValue);
                    },
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // TextField(
                //   // focusNode: _focusNode,
                //   // obscureText: true,
                //   controller: controllerPassword,
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
                //     hintText: "Enter admin's password",
                //     floatingLabelStyle: const TextStyle(
                //         color: Color(0xff312879), fontWeight: FontWeight.w600),
                //     labelText: "Password",
                //   ),
                // ),
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
                        EditAdmin();
                        Navigator.pop(context);
                        // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context) => new Home()));
                      },
                    ),
                  ),
                ])

                // ElevatedButton(
                //   child: Text("EDIT",
                //       style: TextStyle(fontWeight: FontWeight.w600)),
                //   style: ButtonStyle(
                //       foregroundColor:
                //           MaterialStateProperty.all<Color>(Colors.white),
                //       backgroundColor:
                //           MaterialStateProperty.all<Color>(Color(0xff312879)),
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //           RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(5),
                //               side: BorderSide(color: Color(0xff312879))))
                //   ),
                //   onPressed: () {},
                // )

                // RaisedButton(
                //   onPressed: () {},
                //   textColor: Colors.white,
                //   padding: const EdgeInsets.all(0.0),
                //   child: Container(
                //     decoration: const BoxDecoration(
                //       gradient: LinearGradient(
                //         colors: <Color>[
                //           Color(0xFF0D47A1),
                //           Color(0xFF1976D2),
                //           Color(0xFF42A5F5),
                //         ],
                //       ),
                //     ),
                //     padding: const EdgeInsets.all(10.0),
                //     child: const Text('Gradient Color'),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//  https://codesinsider.com/flutter-dropdown-button-example/#:~:text=Dropdown%20button%20is%20a%20material,user%20can%20select%20another%20item.
