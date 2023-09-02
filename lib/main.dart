import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _currentNumber = '';
  String _operation = '';
  double _result = 0;

  void _onNumberPress(String number) {
    setState(() {
      if (_output == '0') {
        _output = number;
      } else {
        _output += number;
      }
      _currentNumber = _output;
    });
  }

  void _onOperationPress(String operation) {
    setState(() {
      if (_currentNumber.isEmpty) {
        // If no number is entered, don't perform any operation.
        return;
      }

      if (_operation.isNotEmpty) {
        // If an operation is already selected, calculate the result so far.
        double secondNumber = double.parse(_currentNumber);
        switch (_operation) {
          case '+':
            _result += secondNumber;
            break;
          case '-':
            _result -= secondNumber;
            break;
          case 'x':
            _result *= secondNumber;
            break;
          case '/':
            _result /= secondNumber;
            break;
        }
      } else {
        // If no operation is selected, initialize the result.
        _result = double.parse(_currentNumber);
      }

      // Clear the current number and set the new operation.
      _currentNumber = '';
      _output = _result.toString();
      _operation = operation;
    });
  }

  void _onEqualsPress() {
    setState(() {
      if (_currentNumber.isEmpty || _operation.isEmpty) {
        // If no number or operation is selected, do nothing.
        return;
      }

      double secondNumber = double.parse(_currentNumber);
      switch (_operation) {
        case '+':
          _result += secondNumber;
          break;
        case '-':
          _result -= secondNumber;
          break;
        case 'x':
          _result *= secondNumber;
          break;
        case '/':
          _result /= secondNumber;
          break;
      }

      // Clear the current number and operation after calculating the result.
      _currentNumber = '';
      _output = _result.toString();
      _operation = '';
      _result = 0; // Reset the result for the next calculation.
    });
  }

  void _onClearPress() {
    setState(() {
      _output = '0';
      _currentNumber = '';
      _operation = '';
      _result = 0;
    });
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons
            .map((button) => _buildCalcButton(button))
            .toList(growable: false),
      ),
    );
  }

  Widget _buildCalcButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (buttonText == '=') {
            _onEqualsPress();
          } else if (buttonText == 'C') {
            _onClearPress();
          } else {
            _onNumberPress(buttonText);
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[800],
          onPrimary: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Simple Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Divider(color: Colors.white, height: 1),
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', 'x']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['0', '.', '=', '+']),
        ],
      ),
    );
  }
}
