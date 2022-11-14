import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../CustomList/ListExercise.dart';
import '../Data/Repository.dart';
import '../Mixin/BaseMixin.dart';
import '../Model/DataModel.dart';
import 'WorkoutScreen.dart';

class WorkoutDataScreen extends StatefulWidget {
  const WorkoutDataScreen({super.key});

  @override
  State<WorkoutDataScreen> createState() => _WorkoutDataScreenState();
}

class _WorkoutDataScreenState extends State<WorkoutDataScreen> with BaseMixin{

  bool result = false;
  late Repository repository;
  List<DataModel> dataList=[];

  getData() async {
    dataList = await repository.getAll();
    return dataList;
  }

  @override
  void initState() {
    // TODO: implement initState
    repository = DataRepository(Hive);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text("Workout List"),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }else{
            return Container(
              padding: const EdgeInsets.all(10),
              child: dataList.isNotEmpty? ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 8),
                scrollDirection: Axis.vertical,
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WorkoutScreen(
                          dataModel: dataList[index],
                          index: index,
                          update: true,
                        )),
                      ).then((value) {
                        if(value){
                          setState(() {
                            getData();
                          });
                        }
                      });
                    },
                    child: ListExercise(
                        dataModel: dataList[index],
                        deleteRecord: (){
                          repository.delete(dataList[index]);
                          setState(() {
                            getData();
                          });
                          showToast(context, "Record Deleted");
                        }
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 12), )
                  :Center(
                child: Text("No Data"),
              ),
            );

          }

        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WorkoutScreen()),
          );

          if(result){
            setState(() {
              getData();
            });
          }
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}