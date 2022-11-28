
import 'package:flutter/material.dart';

import '../model/data_model.dart';

class ListExercise extends StatelessWidget {
  final DataModel? dataModel;
  final VoidCallback? deleteRecord;
  const ListExercise({Key? key, this.dataModel, this.deleteRecord}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            dataModel!.exercise,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weight:   "+dataModel!.weight,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      "Repetitions:    "+dataModel!.repetitions,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete,color: Colors.red,),
                tooltip: 'Delete',
                onPressed: deleteRecord,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
