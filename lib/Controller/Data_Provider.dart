import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/Modal/Data_Modal.dart';


class Data_provider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tweetcontroller = TextEditingController();
  List<Data_Modal> userDataList = [];

  void addData(String editId, String from) {
    String id = DateTime.now()
        .microsecondsSinceEpoch
        .toString(); //this code is genarate auto id;
    Map<String, Object> dataMap = HashMap();
    dataMap["Tweet"] = tweetcontroller.text;
    dataMap["Time"] = DateTime.now();
    dataMap["Time_Millis"] = id;
    if (from == 'edit') {
      db.collection("TWEET").doc(editId).update(dataMap);
    } else {
      db.collection("TWEET").doc(id).set(dataMap);
    }
    getdataa();
    notifyListeners();
  }

  void getdataa() {
    userDataList.clear();
    db.collection("TWEET").get().then((value) {
      userDataList.clear();
      for (var element in value.docs) {
        Map<dynamic, dynamic> map = element.data();
        DateTime addedTime = (map['Time'] as Timestamp).toDate();
        userDataList.add(
          Data_Modal(
            map["Tweet"].toString(),
            addedTime,
            element.id,
          ),
        );
        notifyListeners();
      }
      userDataList.sort(
        (b, a) => a.time.compareTo(b.time),
      );
      notifyListeners();
    });
  }

  void deleteTweet(BuildContext context, String id) {
    db.collection("TWEET").doc(id).delete();
    getdataa();
    // finish(context);
    notifyListeners();
  }

  void editTweet(String id) {
    db.collection("TWEET").doc(id).get().then((value) {
      if (value.exists) {
        tweetcontroller.text = value['Tweet'];
      }
      notifyListeners();
    });
  }
}