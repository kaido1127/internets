import 'package:flutter/material.dart';
import 'package:internet_cafes/models/computer.dart';
import 'package:internet_cafes/screen/widget/computer_card.dart';
class GridViewComputer extends StatefulWidget {
  final List<Computer> list ;
  const GridViewComputer({required this.list,super.key});

  @override
  State<GridViewComputer> createState() => _GridViewComputerState();
}

class _GridViewComputerState extends State<GridViewComputer> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return ComputerCard(computer: widget.list[index]);
      },
    );
  }
}
