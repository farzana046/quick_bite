import 'package:flutter/material.dart';

class Food_Page_Body extends StatefulWidget {
  const Food_Page_Body({super.key});

  @override
  State<Food_Page_Body> createState() => _Food_Page_BodyState();
}

class _Food_Page_BodyState extends State<Food_Page_Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: PageView.builder(
        itemCount: 5,
        itemBuilder: (context, position) {
          return _buildpageItem(position);
        },
      ),
    );
  }

  Widget _buildpageItem(int index) {
    return Container(
      height: 220,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: index.isEven ? Colors.teal : Colors.grey,
      ),
    );
  }
}
