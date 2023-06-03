import 'package:flutter/material.dart';

class YearSelect extends StatefulWidget {
  const YearSelect({Key? key, required this.onSubmit}) : super(key: key);

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

  void _handleSubmit() {
    final text = _controller.text;
    widget.onSubmit(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.grey,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: TextField(
        controller: _controller,
        onSubmitted: (_) => _handleSubmit(),
      ),
    );
  }
}
