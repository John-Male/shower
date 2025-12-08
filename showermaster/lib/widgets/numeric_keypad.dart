import 'package:flutter/material.dart';

class NumericKeypad extends StatefulWidget {
  final String selectedMeasurement;
  final Function(String) onValueChanged;
  final VoidCallback onDismiss;

  const NumericKeypad({
    super.key,
    required this.selectedMeasurement,
    required this.onValueChanged,
    required this.onDismiss,
  });

  @override
  State<NumericKeypad> createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  String _currentValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      color: Colors.grey[800],
      child: Column(
        children: [
          // Header with measurement type and input field
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[700],
            child: Row(
              children: [
                Text(
                  'Width (")',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _currentValue.isEmpty ? '59-7/8' : _currentValue,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          'Outage\n1/8"',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'LEVEL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.straighten, color: Colors.white, size: 16),
                const SizedBox(width: 16),
                const Text(
                  'Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Keypad
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.zero,
              children: [
                _buildKey('1'),
                _buildKey('2'),
                _buildKey('3'),
                _buildKey('('),
                _buildKey('4'),
                _buildKey('5'),
                _buildKey('6'),
                _buildKey(')'),
                _buildKey('7'),
                _buildKey('8'),
                _buildKey('9'),
                _buildKey('/'),
                _buildKey('*'),
                _buildKey('0'),
                _buildKey('#'),
                _buildKey('.'),
                _buildKey('+'),
                _buildKey('-'),
                _buildKey('N'),
                _buildBackspaceKey(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String label) {
    return Material(
      color: Colors.grey[600],
      child: InkWell(
        onTap: () => _onKeyTap(label),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[800]!, width: 0.5),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceKey() {
    return Material(
      color: Colors.grey[600],
      child: InkWell(
        onTap: _onBackspace,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[800]!, width: 0.5),
          ),
          child: const Center(
            child: Icon(
              Icons.backspace,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  void _onKeyTap(String key) {
    setState(() {
      _currentValue += key;
    });
    widget.onValueChanged(_currentValue);
  }

  void _onBackspace() {
    if (_currentValue.isNotEmpty) {
      setState(() {
        _currentValue = _currentValue.substring(0, _currentValue.length - 1);
      });
      widget.onValueChanged(_currentValue);
    }
  }
}