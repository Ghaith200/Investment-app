import 'package:flutter/material.dart';

class SortListWidget extends StatefulWidget {
  final List<String> items; // List to be sorted

  const SortListWidget({super.key, required this.items});

  @override
  SortListWidgetState createState() => SortListWidgetState();
}

class SortListWidgetState extends State<SortListWidget> {
  late List<String> sortedItems;
  String selectedSort = "A-Z";

  @override
  void initState() {
    super.initState();
    sortedItems = List.from(widget.items);
    sortedItems.sort(); // Default sorting A-Z
  }

  void sortList(String order) {
    setState(() {
      if (order == "A-Z") {
        sortedItems.sort();
      } else if (order == "Z-A") {
        sortedItems.sort((a, b) => b.compareTo(a));
      }
      selectedSort = order;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sort Dropdown
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: selectedSort,
            items: ["A-Z", "Z-A"].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              sortList(newValue!);
            },
          ),
        ),
        // Display Sorted List
        Expanded(
          child: ListView.builder(
            itemCount: sortedItems.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(sortedItems[index]));
            },
          ),
        ),
      ],
    );
  }
}
