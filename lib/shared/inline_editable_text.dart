// lib/shared/widgets/inline_editable_text.dart
import 'package:flutter/material.dart';

class InlineEditableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Function(String) onChanged;
  final String? hintText;

  const InlineEditableText({
    super.key,
    required this.text,
    required this.onChanged,
    this.style,
    this.hintText,
  });

  @override
  State<InlineEditableText> createState() => _InlineEditableTextState();
}

class _InlineEditableTextState extends State<InlineEditableText> {
  bool _isEditing = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
    _focusNode = FocusNode();
    
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _saveChanges();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() => _isEditing = false);
    if (_controller.text != widget.text) {
      widget.onChanged(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: widget.style,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: const UnderlineInputBorder(),
          contentPadding: EdgeInsets.zero,
        ),
        onSubmitted: (_) => _saveChanges(),
      );
    }

    return GestureDetector(
      onDoubleTap: () {
        setState(() => _isEditing = true);
        _focusNode.requestFocus();
      },
      child: Text(
        widget.text.isEmpty ? (widget.hintText ?? 'Tap to edit') : widget.text,
        style: widget.style?.copyWith(
          color: widget.text.isEmpty ? Colors.grey : null,
        ),
      ),
    );
  }
}
