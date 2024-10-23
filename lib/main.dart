import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // manage the result section
  double sum = 0;
  double difference = 0;
  double product = 0;
  double quotient = 0;

  // either use a TextEditingController for each input field to get the value
  TextEditingController addNum1Controller = TextEditingController();
  TextEditingController addNum2Controller = TextEditingController();
  TextEditingController subNum1Controller = TextEditingController();
  TextEditingController subNum2Controller = TextEditingController();
  TextEditingController mulNum1Controller = TextEditingController();
  TextEditingController mulNum2Controller = TextEditingController();
  TextEditingController divNum1Controller = TextEditingController();
  TextEditingController divNum2Controller = TextEditingController();

  void performOperation(String operation) {
    double num1;
    double num2;
    double result = 0;

    switch (operation) {
      case "+":
        num1 = double.tryParse(addNum1Controller.text) ?? 0;
        num2 = double.tryParse(addNum2Controller.text) ?? 0;
        result = num1 + num2;
        setState(() {
          sum = result;
        });
        break;
      case "-":
        num1 = double.tryParse(subNum1Controller.text) ?? 0;
        num2 = double.tryParse(subNum2Controller.text) ?? 0;
        result = num1 - num2;
        setState(() {
          difference = result;
        });
        break;
      case "*":
        num1 = double.tryParse(mulNum1Controller.text) ?? 0;
        num2 = double.tryParse(mulNum2Controller.text) ?? 0;
        result = num1 * num2;
        setState(() {
          product = result;
        });
        break;
      case "/":
        num1 = double.tryParse(divNum1Controller.text) ?? 0;
        num2 = double.tryParse(divNum2Controller.text) ?? 0;
        result = num2 != 0 ? num1 / num2 : 0; // Prevent division by zero
        setState(() {
          quotient = result;
        });
        break;
    }
  }

  void clearInputs() {
    setState(() {
      addNum1Controller.clear();
      addNum2Controller.clear();
      subNum1Controller.clear();
      subNum2Controller.clear();
      mulNum1Controller.clear();
      mulNum2Controller.clear();
      divNum1Controller.clear();
      divNum2Controller.clear();

      sum = 0;
      difference = 0;
      product = 0;
      quotient = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit 5 Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Addition Row
            buildOperationRow("+", addNum1Controller, addNum2Controller, sum),
            // Subtraction Row
            buildOperationRow("-", subNum1Controller, subNum2Controller, difference),
            // Multiplication Row
            buildOperationRow("*", mulNum1Controller, mulNum2Controller, product),
            // Division Row
            buildOperationRow("/", divNum1Controller, divNum2Controller, quotient),

            // Clear Button
            ElevatedButton(
              onPressed: clearInputs,
              child: const Text("Clear All"),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for each operation row
  Widget buildOperationRow(String operation, TextEditingController firstNumController,
      TextEditingController secondNumController, double result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextField(
            controller: firstNumController,
            decoration: const InputDecoration(labelText: "First Number"),
            keyboardType: TextInputType.number,
          ),
        ),
        Text(" $operation "),
        Expanded(
          child: TextField(
            controller: secondNumController,
            decoration: const InputDecoration(labelText: "Second Number"),
            keyboardType: TextInputType.number,
          ),
        ),
        Text(" = $result"),
        TextButton.icon(
          onPressed: () => performOperation(operation),
          icon: const Icon(Icons.calculate),
          label: const Text("Calculate"),
        ),
      ],
    );
  }
}