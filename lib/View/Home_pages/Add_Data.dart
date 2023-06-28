import 'package:flutter/material.dart';

import 'package:machine_test/Controller/Change_Page.dart';
import 'package:machine_test/Controller/Color_Controller.dart';
import 'package:machine_test/Controller/Data_Provider.dart';

import 'package:provider/provider.dart';

class Add_Data extends StatelessWidget {
  String id, from;
  Add_Data({Key? key, required this.id, required this.from}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: greentheme,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: height / 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child:
                    Consumer<Data_provider>(builder: (context, value, child) {
                  return TextFormField(
                    autofocus: false,
                    maxLength: 280,
                    keyboardType: TextInputType.text,
                    controller: value.tweetcontroller,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: white),
                      hintText: 'Enter Your data',
                      contentPadding: const EdgeInsets.all(11),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter data";
                      } else {
                        return null;
                      }
                    },
                  );
                }),
              ),
              Consumer<Data_provider>(builder: (context, value, child) {
                return ElevatedButton(
                    onPressed: () {
                      final FormState? forme = _formKey.currentState;
                      if (forme!.validate()) {
                        value.addData(id, from);
                        poping(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                    child: Text(
                      "Submit Your data",
                      style: TextStyle(color: white),
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
