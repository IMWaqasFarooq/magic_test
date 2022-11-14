

import 'package:flutter/material.dart';


class BottomSheetWidget extends StatelessWidget {
  final List? exercises;



  BottomSheetWidget({
    Key? key,
    this.exercises,

  })
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    if(exercises!=null) {
      return SafeArea(
      child: Container(

        color: Colors.transparent, //could change this to Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:  EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text( "Select Exercise",
                    style: TextStyle(
                        fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                   )],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(
                 bottom: 30,
                left: 8,
                right: 8
              ),
              child: ListView.builder(
                 shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: exercises!.length,
                itemBuilder:(context, index) {

                      return InkWell(
                        onTap: (){
                          Navigator.pop(context,exercises![index]);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey
                              )
                            ),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(exercises![index],
                                 style: TextStyle(
                                   fontSize: 14,

                                 ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );



              }, ),
            ),
          ],
        ),
      ),
    );
    }  else {
      return SizedBox();
    }
  }
}
