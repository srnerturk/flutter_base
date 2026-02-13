import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../extensions/context_extensions.dart';
import '../utils/debouncer.dart';

/// Adaptive search field with built-in debounce and clear button.
///
/// Uses [CupertinoSearchTextField] on iOS and a styled [TextField] on Android.
/// Integrates with the [Debouncer] utility for delayed search callbacks.
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.hint,
    this.autofocus = false,
    this.debounce = const Duration(milliseconds: 300),
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String? hint;
  final bool autofocus;
  final Duration debounce;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _controller;
  late final Debouncer _debouncer;
  bool _ownsController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _ownsController = true;
    }
    _debouncer = Debouncer(delay: widget.debounce);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (_ownsController) _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    if (widget.debounce == Duration.zero) {
      widget.onChanged?.call(value);
    } else {
      _debouncer.run(() => widget.onChanged?.call(value));
    }
  }

  void _handleClear() {
    _controller.clear();
    _debouncer.cancel();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (context.isApplePlatform) {
      return CupertinoSearchTextField(
        controller: _controller,
        placeholder: widget.hint ?? 'Search',
        autofocus: widget.autofocus,
        onChanged: _handleChanged,
        onSuffixTap: _handleClear,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.sm,
          vertical: Spacing.sm,
        ),
      );
    }

    return TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      onChanged: _handleChanged,
      decoration: InputDecoration(
        hintText: widget.hint ?? 'Search',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _handleClear,
              )
            : null,
      ),
    );
  }
}
