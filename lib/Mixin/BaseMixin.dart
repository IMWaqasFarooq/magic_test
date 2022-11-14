
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin BaseMixin{

  showToast(BuildContext context, String msg){

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }
}