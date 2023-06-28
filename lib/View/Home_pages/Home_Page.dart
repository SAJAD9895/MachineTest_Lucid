// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:machine_test/Controller/Data_Provider.dart';

import 'package:provider/provider.dart';

import '../../Controller/Change_Page.dart';
import '../../Controller/Color_Controller.dart';
import 'Add_Data.dart';
import 'Logout_User.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Data_provider get = Provider.of<Data_provider>(context, listen: false);
    get.getdataa();
    return Scaffold(
      backgroundColor: greentheme,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            get.tweetcontroller.clear();
            nextpage(
                Add_Data(
                  id: '',
                  from: '',
                ),
                context);
          },
          label: const Text(
            "Enter your data",
            style: TextStyle(color: Colors.black),
          )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: greentheme,
        title: const Center(
            child: Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            "DATA",
            style: TextStyle(color: Colors.black),
          ),
        )),
        actions: [
          IconButton(
              onPressed: () {
                logOut(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: height * .03,
            ),
            Consumer<Data_provider>(builder: (context, value, child) {
              return SizedBox(
                height: height,
                width: width,
                child: ListView.builder(
                    itemCount: value.userDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = value.userDataList[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onLongPress: () {
                              deleteAndeditTweet(context, item.id.toString());
                            },
                            child: Container(
                              height: height / 7,
                              width: width / 1.1,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [BoxShadow(blurRadius: 10)],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: width / 1.4,
                                        child: Text(item.tweet.toString())),
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        value.editTweet(item.id.toString());
                                        nextpage(
                                            Add_Data(
                                              id: item.id.toString(),
                                              from: 'edit',
                                            ),
                                            context);
                                      },
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }

  deleteAndeditTweet(BuildContext context, String id) {
    AlertDialog alert = AlertDialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Center(
        child: Text(
          "Do you want to delete this data",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      ),
      content: SizedBox(
        height: 50,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<Data_provider>(builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 37,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100),
                      child: TextButton(
                          child: const Text(
                            'NO',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            poping(context);
                          }),
                    ),
                    Container(
                      height: 37,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100),
                      child: TextButton(
                          child: const Text('YES',
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            value.deleteTweet(context, id);
                          }),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
