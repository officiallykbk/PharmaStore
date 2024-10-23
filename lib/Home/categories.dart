import 'package:flutter/material.dart';
import 'package:pharmaplus/provider/alldrugs_provider.dart';
import 'package:provider/provider.dart';

/* To make this work, consider causing the clicking of 
any triggering a tailored sorting algorithm of the dataModel
or
there should be custom sorted list for all categories and we just have 
to switch to the right list everytime a category is picked*/

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

List cat = ['All(A-Z)', 'Price', 'Group'];
List actions = ['Brand_Name', 'price', 'Generic_Name'];
int selected_index = 0;

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cat.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selected_index = index;
            });
            context.read<AlldrugsProvider>().sort(actions[selected_index]);
          },
          child: Center(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: selected_index == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(10),
              child: Text(
                cat[index],
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        );
      },
    );
  }
}
