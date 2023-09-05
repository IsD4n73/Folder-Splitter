import 'package:flutter/material.dart';
import 'package:folder_splitter/widget/split_by_ammount.dart';
import 'package:folder_splitter/widget/split_by_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Folder Splitter",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff202020),
        bottom: const TabBar(
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              text: "Dividi per Grandezza",
            ),
            Tab(
              text: "Dividi per Quantità",
            ),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          SplitBySize(),
          SplitByAmmount(),
        ],
      ),
    );
  }
}
