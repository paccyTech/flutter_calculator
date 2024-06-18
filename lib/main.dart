import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = '0';
  String _expression = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _expression = '';
      } else if (buttonText == '=') {
        try {
          _output = _evaluateExpression(_expression);
          _expression = _output;
        } catch (e) {
          _output = 'Welcome';
          _expression = '';
        }
      } else {
        if (_output == '0' && buttonText != '.') {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        _expression = _output;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      final parsedExpression = expression.replaceAll('x', '*').replaceAll('÷', '/');
      final result = double.parse(parsedExpression).toString();
      return result;
    } catch (e) {
      return 'Welcome';
    }
  }

  Widget _buildButton(String buttonText, Color color, {double height = 1}) {
    return Expanded(
      flex: height.toInt(),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton('C', Colors.grey.shade800),
                  _buildButton('+/-', Colors.grey.shade800),
                  _buildButton('%', Colors.grey.shade800),
                  _buildButton('÷', Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('7', Colors.grey.shade700),
                  _buildButton('8', Colors.grey.shade700),
                  _buildButton('9', Colors.grey.shade700),
                  _buildButton('x', Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4', Colors.grey.shade700),
                  _buildButton('5', Colors.grey.shade700),
                  _buildButton('6', Colors.grey.shade700),
                  _buildButton('-', Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1', Colors.grey.shade700),
                  _buildButton('2', Colors.grey.shade700),
                  _buildButton('3', Colors.grey.shade700),
                  _buildButton('+', Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('0', Colors.grey.shade700, height: 2),
                  _buildButton('.', Colors.grey.shade700),
                  _buildButton('=', Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
