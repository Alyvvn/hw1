import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String displayText = "0";
  String firstOperand = "";
  String operator = "";
  String secondOperand = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        displayText = "0";
        firstOperand = "";
        operator = "";
        secondOperand = "";
        return;
      }

      if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (firstOperand.isEmpty) {
          firstOperand = displayText;
        }
        operator = value;
        displayText = "0";
        return;
      }

      if (value == "=") {
        if (firstOperand.isNotEmpty && operator.isNotEmpty) {
          secondOperand = displayText;
          double num1 = double.parse(firstOperand);
          double num2 = double.parse(secondOperand);
          double result = 0;

          if (operator == "+") result = num1 + num2;
          if (operator == "-") result = num1 - num2;
          if (operator == "*") result = num1 * num2;
          if (operator == "/") {
            if (num2 == 0) {
              displayText = "Error";
              firstOperand = "";
              operator = "";
              secondOperand = "";
              return;
            } else {
              result = num1 / num2;
            }
          }

          displayText = result.toString();
          firstOperand = "";
          operator = "";
          secondOperand = "";
        }
        return;
      }

      if (value == ".") {
        if (!displayText.contains(".")) {
          displayText += ".";
        }
        return;
      }

      if (displayText == "0") {
        displayText = value;
      } else {
        displayText += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(24),
            child: Text(
              displayText,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              buildButtonRow(["7", "8", "9", "/"]),
              buildButtonRow(["4", "5", "6", "*"]),
              buildButtonRow(["1", "2", "3", "-"]),
              buildButtonRow(["0", ".", "=", "+"]),
              buildButtonRow(["C"]),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((btnText) {
        return ElevatedButton(
          onPressed: () {
            _onButtonPressed(btnText);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
          ),
          child: Text(btnText, style: const TextStyle(fontSize: 24)),
        );
      }).toList(),
    );
  }
}
