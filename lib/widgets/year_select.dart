import 'package:flutter/material.dart';

class YearSelect extends StatefulWidget {
  const YearSelect({super.key, required this.onSubmit});

  final Function(String text) onSubmit;

  @override
  State<YearSelect> createState() => _YearSelectState();
}

class _YearSelectState extends State<YearSelect> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: DateTime.now().year.toString());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        color: Colors.grey,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: TextField(
        controller: _controller,
      ),
    );
  }
}
