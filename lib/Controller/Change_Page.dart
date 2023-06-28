import 'package:flutter/material.dart';

nextpage(var className, var context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => className),
  );
}
replacementPushing(var className, var context){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => className),
  );
}
void poping(context) {
  Navigator.pop(context);
}