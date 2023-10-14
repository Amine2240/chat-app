import 'package:flutter/material.dart';

class category {
  final String text;
  final int id;
  category({required this.id, required this.text});
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List categorylist = [
    category(id: 0, text: "All"),
    category(id: 1, text: "Online")
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...categorylist.map(
            (item) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    index = item.id;
                  });
                },
                child: Text(
                  item.text,
                  style: TextStyle(
                      color: index == item.id ? Colors.white : Colors.black45,
                      fontSize: 30),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
