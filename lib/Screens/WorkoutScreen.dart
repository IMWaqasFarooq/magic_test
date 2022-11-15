import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:magic_test/Screens/BottomSheetWidget.dart';
import 'package:magic_test/Data/Repository.dart';
import 'package:magic_test/Mixin/BaseMixin.dart';
import '../../Model/DataModel.dart';
import '../DataBox/DataBox.dart';


class WorkoutScreen extends StatefulWidget {
  final DataModel? dataModel;
  final bool? update;
  final int? index;
const WorkoutScreen({Key? key , this.dataModel, this.index, this.update }) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with BaseMixin {
  late TextEditingController wController, rController;

  final exerciseList = [
    "Barbell row",
    "Bench press",
    "Shoulder press",
    "Deadlift",
    "Squat",
  ];

   String exerciseName="";
   late bool update;
   late int index;
   late DataModel dataModel;

  @override
  void initState() {
    // TODO: implement initState
    wController = TextEditingController();
    rController = TextEditingController();

    update = widget.update??false;

    if(update){
      dataModel = widget.dataModel!;
      index = widget.index!;
      exerciseName = dataModel.exercise;
      rController.text = dataModel.repetitions;
      wController.text=dataModel.weight;
    }




    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    wController.dispose();
    rController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(

        title:Text(
          "Workout"
        )
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: (){
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        )),
                    context: context,
                    builder: (builder) {
                      return BottomSheetWidget(
                        exercises: exerciseList,
                      );

                    }
                ).then((value) {
                  if(value is String){
                    setState(() {
                      exerciseName = value;
                    });

                  }
                });
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    exerciseName.isEmpty?"Select Exercise":exerciseName,
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: wController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                    "weight (lb)",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: rController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                  "Repetitions",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: (){
              if(rController.text.isNotEmpty && wController.text.isNotEmpty && exerciseName.isNotEmpty){
                Repository repository = DataRepository(DataBox());
                DataModel data = DataModel(exerciseName, wController.text, rController.text);
                if(update){
                  repository.update(index, data);
                }else{
                  repository.save(data);
                }
                showToast(context, update?"Exercise Updated":"Exercise Added");
                Navigator.pop(context, true);

              }else{
                showToast(context, "Please fill all fields");
              }

            }, child: Text(update?"UPDATE":"ADD"))
          ],
        ),
      ),
    );
  }


}
