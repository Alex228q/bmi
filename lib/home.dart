import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double bmiResult = 0;

  void calculateBMI({required double weight, required double height}) {
    final double bmi = weight / pow(height, 2);
    setState(() {
      bmiResult = bmi;
    });
  }

  void clearResult() {
    setState(() {
      bmiResult = 0;
      heightController.clear();
      weightController.clear();
    });
  }

  String determineCategory({required double bmiResult}) {
    if (bmiResult < 1) {
      return '';
    } else if (bmiResult < 18.5) {
      return 'Underweight';
    } else if (bmiResult <= 24.9) {
      return 'Normal Weight';
    } else if (bmiResult <= 29.9) {
      return 'Overweight';
    } else if (bmiResult <= 34.9) {
      return 'Obesity Class I';
    } else if (bmiResult <= 39.9) {
      return 'Obesity Class II';
    } else {
      return 'Obesity Class III';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('BMI Calculator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Weight (kg)')),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (m)',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (weightController.text.isNotEmpty &&
                      heightController.text.isNotEmpty) {
                    calculateBMI(
                      weight: double.parse(weightController.text),
                      height: double.parse(heightController.text),
                    );
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: const Text('CALCULATE'),
              ),
              const SizedBox(height: 20.0),
              bmiResult > 0.0
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          const Text('Result:'),
                          const SizedBox(height: 10.0),
                          Text(
                            bmiResult.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 35.0),
                          ),
                          Text(
                            determineCategory(bmiResult: bmiResult),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20.0),
              bmiResult > 0.0
                  ? ElevatedButton(
                      onPressed: () {
                        clearResult();
                      },
                      child: const Text('CLEAR'),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
