import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '0';
  dynamic opr = '';
  dynamic preOpr = '';

  // Updated button widget
  Widget calcButton(String btntxt, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: btnColor,
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        btntxt,
        style: TextStyle(fontSize: 30, color: txtColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3694E1), // Background color
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: const Color(0xFF1A5F91),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(20),
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50, // Reduced font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('7', Colors.blueGrey[800]!, Colors.white),
                calcButton('8', Colors.blueGrey[800]!, Colors.white),
                calcButton('9', Colors.blueGrey[800]!, Colors.white),
                calcButton('x', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('4', Colors.blueGrey[800]!, Colors.white),
                calcButton('5', Colors.blueGrey[800]!, Colors.white),
                calcButton('6', Colors.blueGrey[800]!, Colors.white),
                calcButton('-', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcButton('1', Colors.blueGrey[800]!, Colors.white),
                calcButton('2', Colors.blueGrey[800]!, Colors.white),
                calcButton('3', Colors.blueGrey[800]!, Colors.white),
                calcButton('+', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blueGrey[800],
                    padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                calcButton('.', Colors.blueGrey[800]!, Colors.white),
                calcButton('=', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      finalResult = performOperation(preOpr);
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      finalResult = performOperation(opr);
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = formatResult(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = "$result.";
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result = result.toString().startsWith('-') ? result.toString().substring(1) : '-$result';
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String performOperation(String operator) {
    switch (operator) {
      case '+':
        return formatResult((numOne + numTwo).toString());
      case '-':
        return formatResult((numOne - numTwo).toString());
      case 'x':
        return formatResult((numOne * numTwo).toString());
      case '/':
        return numTwo == 0 ? "Error" : formatResult((numOne / numTwo).toString());
      default:
        return formatResult(result);
    }
  }

  String formatResult(String value) {
    double num = double.parse(value);
    if (num % 1 == 0) {
      return num.toInt().toString(); // Keep as integer if no decimal value
    } else {
      return num.toStringAsFixed(3); // Otherwise, round to 3 decimal places
    }
  }
}
