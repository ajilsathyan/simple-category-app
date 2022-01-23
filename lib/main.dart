import 'package:flutter/material.dart';
import 'package:simple_cat_app/location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LocationScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Category> parentList = [
    Category(id: '1', name: "Medicine"),
    Category(id: '2', name: "Vitamins & Supplements"),
    Category(id: '3', name: "Hair Care"),
    Category(id: '4', name: "Skin Care"),
    Category(id: '5', name: "Makeup & Accessories"),
    Category(id: '6', name: "Medicine"),
    Category(id: '7', name: "Vitamins & Supplements"),
    Category(id: '8', name: "Hair Care"),
    Category(id: '9', name: "Skin Care"),
    Category(id: '10', name: "Makeup & Accessories"),
  ];

  List<SubCategory> medicineList = [
    SubCategory(id: '1', name: "Medicine 1"),
    SubCategory(id: '2', name: "Medicine 2"),
    SubCategory(id: '3', name: "Medicine 3"),
    SubCategory(id: '4', name: "Medicine 4"),
    SubCategory(id: '5', name: "Medicine 5"),
  ];
  List<SubCategory> vitaminsList = [
    SubCategory(id: '1', name: "Vitamins & Supplements 1"),
    SubCategory(id: '2', name: "Vitamins & Supplements 2"),
    SubCategory(id: '3', name: "Vitamins & Supplements 3"),
    SubCategory(id: '4', name: "Vitamins & Supplements 4"),
    SubCategory(id: '5', name: "Vitamins & Supplements 5"),
  ];
  List<SubCategory> hairList = [
    SubCategory(id: '1', name: "Hair Care 1"),
    SubCategory(id: '2', name: "Hair Care 2"),
    SubCategory(id: '3', name: "Hair Care 3"),
    SubCategory(id: '4', name: "Hair Care 4"),
    SubCategory(id: '5', name: "Hair Care 5"),
  ];
  List<SubCategory> skinList = [
    SubCategory(id: '1', name: "Skin Care 1"),
    SubCategory(id: '2', name: "Skin Care 2"),
    SubCategory(id: '3', name: "Skin Care 3"),
    SubCategory(id: '4', name: "Skin Care 4"),
    SubCategory(id: '5', name: "Skin Care 5"),
  ];
  List<SubCategory> makeupList = [
    SubCategory(id: '1', name: "MakeUp 1"),
    SubCategory(id: '2', name: "MakeUp 2"),
    SubCategory(id: '3', name: "MakeUp 3"),
    SubCategory(id: '4', name: "MakeUp 4"),
    SubCategory(id: '5', name: "MakeUp 5"),
  ];

  List<SubCategory> getListItems({String? name}) {
    if (name == 'Medicine') {
      return medicineList;
    } else if (name == 'Vitamins & Supplements') {
      return vitaminsList;
    } else if (name == 'Hair Care') {
      return hairList;
    } else if (name == 'Skin Care') {
      return skinList;
    } else if (name == 'Makeup & Accessories') {
      return makeupList;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: w,
        height: h,
        child: ListView.builder(
            itemCount: parentList.length,
            itemBuilder: (context, i) {
              return ExpansionTile(
                title: Text(parentList[i].name!),
                children: [
                  Container(
                    width: w,
                    height: 160,
                    child: ListView.builder(
                        itemCount:
                            getListItems(name: parentList[i].name!).length,
                        itemBuilder: (context, k) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child: Text(
                                getListItems(name: parentList[i].name!)[k]
                                    .name!,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }
}

/// Model Class For parent Category
class Category {
  String? name;
  String? id;
  Category({this.name, this.id});
}

class SubCategory {
  String? name;
  String? id;
  SubCategory({this.name, this.id});
}
