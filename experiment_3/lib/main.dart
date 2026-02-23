import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = '';
  String _result = '0';
  double _firstOperand = 0;
  String _operator = '';
  bool _shouldResetInput = false;

  void _onButton(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '0';
        _firstOperand = 0;
        _operator = '';
        _shouldResetInput = false;
      } else if (value == '⌫') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          if (_input.isEmpty) _input = '';
        }
      } else if (value == '+/-') {
        if (_input.isNotEmpty && _input != '-') {
          if (_input.startsWith('-')) {
            _input = _input.substring(1);
          } else {
            _input = '-$_input';
          }
        }
      } else if (['+', '-', '×', '÷'].contains(value)) {
        if (_input.isNotEmpty) {
          _firstOperand = double.tryParse(_input) ?? 0;
          _operator = value;
          _shouldResetInput = true;
        }
      } else if (value == '=') {
        if (_operator.isNotEmpty && _input.isNotEmpty) {
          final second = double.tryParse(_input) ?? 0;
          double res;
          switch (_operator) {
            case '+':
              res = _firstOperand + second;
              break;
            case '-':
              res = _firstOperand - second;
              break;
            case '×':
              res = _firstOperand * second;
              break;
            case '÷':
              res = second != 0 ? _firstOperand / second : double.nan;
              break;
            default:
              res = second;
          }
          _result = res.isNaN
              ? 'Error'
              : (res % 1 == 0 ? res.toInt().toString() : res.toString());
          _input = _result;
          _operator = '';
          _shouldResetInput = true;
        }
      } else if (value == '.') {
        if (_shouldResetInput) {
          _input = '0.';
          _shouldResetInput = false;
        } else if (!_input.contains('.')) {
          _input = _input.isEmpty ? '0.' : '$_input.';
        }
      } else {
        // digit
        if (_shouldResetInput) {
          _input = value;
          _shouldResetInput = false;
        } else {
          _input = _input == '0' ? value : '$_input$value';
        }
      }
    });
  }

  Widget _buildButton(
    String label, {
    Color? color,
    Color? textColor,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF333333),
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 22),
            elevation: 2,
          ),
          onPressed: () => _onButton(label),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String displayInput = _input.isEmpty
        ? (_operator.isNotEmpty ? '$_firstOperand ${_operator} ' : '0')
        : (_operator.isNotEmpty && _shouldResetInput == false
              ? '${_firstOperand.toInt()} $_operator $_input'
              : _input);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    displayInput,
                    style: const TextStyle(fontSize: 28, color: Colors.grey),
                    maxLines: 2,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _result,
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),

          // Button grid
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton(
                      'C',
                      color: const Color(0xFFA5A5A5),
                      textColor: Colors.black,
                    ),
                    _buildButton(
                      '+/-',
                      color: const Color(0xFFA5A5A5),
                      textColor: Colors.black,
                    ),
                    _buildButton(
                      '⌫',
                      color: const Color(0xFFA5A5A5),
                      textColor: Colors.black,
                    ),
                    _buildButton(
                      '÷',
                      color: const Color(0xFFFF9F0A),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton(
                      '×',
                      color: const Color(0xFFFF9F0A),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton(
                      '-',
                      color: const Color(0xFFFF9F0A),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton(
                      '+',
                      color: const Color(0xFFFF9F0A),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0', flex: 2),
                    _buildButton('.'),
                    _buildButton(
                      '=',
                      color: const Color(0xFFFF9F0A),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
