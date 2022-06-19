import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddOutlet extends StatefulWidget {
  const AddOutlet({Key? key}) : super(key: key);

  @override
  _AddOutletState createState() => _AddOutletState();
}

class _AddOutletState extends State<AddOutlet> {
  TextEditingController controllerNama_outlet =  new TextEditingController();
  TextEditingController controllerAlamat = new TextEditingController();
  // TextEditingController controllerGender = new TextEditingController();
  TextEditingController controllerTlp = new TextEditingController();

  // String dropdownValue = 'Select Gender';


  void AddOutlet() {
    var url = "http://localhost:8080/outlet";
    http.post(Uri.parse(url), body: {
      "nama_outlet": controllerNama_outlet.text,
      "alamat": controllerAlamat.text,
      "tlp": controllerTlp.text,
    });
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
              'Add Outlet',
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
                        AddOutlet();
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
