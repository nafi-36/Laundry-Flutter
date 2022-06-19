import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPaket extends StatefulWidget {
  // const EditPaket({Key? key}) : super(key: key);

  final List list;
  final int index;

  EditPaket({required this.list, required this.index});

  @override
  _EditPaketState createState() => _EditPaketState();
}

class ListItem {
  String value;
  String name;
  ListItem(this.value, this.name);
}

class _EditPaketState extends State<EditPaket> {
  late TextEditingController controllerNamePaket;
  late TextEditingController controllerHarga;
  late TextEditingController controllerImage;

  String? dropdownValue;

  List<ListItem> _dropdownItems = [
    // ListItem('null', "Select Category"),
    ListItem('kilo', "Kilo"),
    ListItem('bed_cover', "Bed Cover"),
    ListItem('blanket', "blanket"),
    ListItem('tshirt', "T-shirt"),
    ListItem('others', "others"),

  ];

  void EditPaket() {
    var url =
        "http://localhost:8080/paket/${widget.list[widget.index]['id_paket']}";
    http.put(Uri.parse(url), body: {
      "jenis" : dropdownValue.toString(),
      "nama_paket": controllerNamePaket.text,
      "harga": controllerHarga.text,
      "image": controllerImage.text,
    });
  }


  @override
  void initState() {
    super.initState();
    controllerNamePaket = new TextEditingController(text: widget.list[widget.index]['nama_paket']);
    controllerHarga = new TextEditingController(text: widget.list[widget.index]['harga'].toString());
    dropdownValue = widget.list[widget.index]['jenis'];
    controllerImage = new TextEditingController(text: widget.list[widget.index]['image']);
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
                    controller: controllerNamePaket,
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
                      hintText: "Enter package's name",
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
                  controller: controllerHarga,
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
                    hintText: "Enter package's price",
                    floatingLabelStyle: const TextStyle(
                        color: Color(0xff312879), fontWeight: FontWeight.w600),
                    labelText: "Price",
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
                  controller: controllerImage,
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
                    hintText: "Enter package's image url",
                    floatingLabelStyle: const TextStyle(
                        color: Color(0xff312879), fontWeight: FontWeight.w600),
                    labelText: "Image",
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
                        "Select Type",
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
                        EditPaket();
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
