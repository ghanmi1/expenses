import 'package:flutter/material.dart';
import 'package:some_project/main.dart';

class ChartBar extends StatelessWidget {
  final double spindingAmount;
  final String day;
  final double spindingPrctg;

  ChartBar(this.spindingAmount, this.day, this.spindingPrctg);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (cntx, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spindingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 12,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Mycolor,
                  ),
                  color: Mycolor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: 1 - spindingPrctg,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colortext)),
              ),
            ]),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(day)))
        ],
      );
    });
  }
}
