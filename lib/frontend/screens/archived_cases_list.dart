import 'package:counselaicompanion/frontend/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';

class Item {
  final int id;
  final String task;
  final String image;
  Item({required this.id, required this.task, required this.image});
}

class ArchivedCases {
  static int length = 3;
  static final items = [
    Item(id: 0, task: 'Case 1', image: "assets/images/case-1.png"),
    Item(id: 1, task: 'Case 2', image: "assets/images/case-2.png"),
    Item(id: 2, task: 'Case 3', image: "assets/images/case-3.png"),
  ];
}

class ArchivedCasesList extends StatefulWidget {
  const ArchivedCasesList({Key? key}) : super(key: key);
  @override
  State<ArchivedCasesList> createState() => _ArchivedCasesListState();
}

class _ArchivedCasesListState extends State<ArchivedCasesList> {
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
            itemCount: ArchivedCases.length,
            itemBuilder: (context, i) {
              return Dismissible(
                background: Container(
                  color: Colors.green,
                  child: const Icon(Icons.check_box_outlined,
                      size: 60, color: Colors.white),
                ),
                key: ValueKey<Object>(ArchivedCases.items[i]),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    ArchivedCases.items.removeAt(i);
                    ArchivedCases.length = ArchivedCases.length - 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PDFWrapper()),
                  );
                },
                child: SizedBox(
                    child: Column(children: <Widget>[
                  Image.asset(ArchivedCases.items[i].image),
                  Text(ArchivedCases.items[i].task,
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
