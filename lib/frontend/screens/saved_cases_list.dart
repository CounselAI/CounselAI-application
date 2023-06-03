import 'package:counselaicompanion/frontend/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';

class Item {
  final int id;
  final String task;
  final String image;
  Item({required this.id, required this.task, required this.image});
}

class SavedCases {
  static int length = 3;
  static final items = [
    Item(
        id: 0,
        task: 'Marriage Counsel Report: 2017-2020',
        image: "assets/images/case-5.jpg"),
    Item(
        id: 1,
        task: 'Criminal Counsel Report: 2015-2017',
        image: "assets/images/case-6.jpeg"),
    Item(
        id: 2,
        task: 'Marriage Counsel Report: 2018-2019',
        image: "assets/images/case-7.jpg"),
  ];
}

class SavedCasesList extends StatefulWidget {
  const SavedCasesList({Key? key}) : super(key: key);
  @override
  State<SavedCasesList> createState() => _SavedCasesListState();
}

class _SavedCasesListState extends State<SavedCasesList> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height - 0.2 * height,
        child: ListView.builder(
            //scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            itemCount: SavedCases.length,
            itemBuilder: (context, i) {
              return Dismissible(
                background: Container(
                  color: Colors.green,
                  child: const Icon(Icons.check_box_outlined,
                      size: 60, color: Colors.white),
                ),
                key: ValueKey<Object>(SavedCases.items[i]),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    SavedCases.items.removeAt(i);
                    SavedCases.length = SavedCases.length - 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PDFWrapper()),
                  );
                },
                child: SizedBox(
                    child: Column(children: <Widget>[
                  Image.asset(SavedCases.items[i].image),
                  Text(SavedCases.items[i].task,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.5))
                ])),
              );
            }));
  }
}
