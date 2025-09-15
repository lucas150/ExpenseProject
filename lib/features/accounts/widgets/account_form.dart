// import 'package:flutter/material.dart';
// import '../../../core/models/account_model.dart';
// import 'package:uuid/uuid.dart';

// class AccountForm extends StatefulWidget {
//   final Account? existing;
//   final void Function(Account) onSubmit;
//   const AccountForm({super.key, this.existing, required this.onSubmit});

//   @override
//   State<AccountForm> createState() => _AccountFormState();
// }

// class _AccountFormState extends State<AccountForm> {
//   late final _name = TextEditingController(text: widget.existing?.name);
//   late final _balance = TextEditingController(
//     text: widget.existing?.balance.toString() ?? '',
//   );
//   String _type = 'Cash';

//   @override
//   Widget build(BuildContext context) => AlertDialog(
//     title: Text(widget.existing == null ? 'New Account' : 'Edit Account'),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TextField(
//           controller: _name,
//           decoration: const InputDecoration(labelText: 'Name'),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: _balance,
//           decoration: const InputDecoration(labelText: 'Opening Balance'),
//           keyboardType: TextInputType.number,
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: _type,
//           items: const [
//             DropdownMenuItem(value: 'Cash', child: Text('Cash')),
//             DropdownMenuItem(value: 'Bank', child: Text('Bank')),
//             DropdownMenuItem(value: 'Wallet', child: Text('Wallet')),
//           ],
//           onChanged: (v) => setState(() => _type = v!),
//           decoration: const InputDecoration(labelText: 'Type'),
//         ),
//       ],
//     ),
//     actions: [
//       TextButton(
//         onPressed: Navigator.of(context).pop,
//         child: const Text('Cancel'),
//       ),
//       ElevatedButton(
//         onPressed: () {
//           final acc = Account(
//             id: widget.existing?.id ?? const Uuid().v4(),
//             name: _name.text,
//             balance: double.tryParse(_balance.text) ?? 0,
//             type: _type,
//             role: AccountRole.both,
//           );
//           widget.onSubmit(acc);
//           Navigator.of(context).pop();
//         },
//         child: const Text('Save'),
//       ),
//     ],
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/models/account_model.dart';
import 'package:uuid/uuid.dart';

class AccountForm extends StatefulWidget {
  final Account? existing;
  final void Function(Account) onSubmit;
  const AccountForm({super.key, this.existing, required this.onSubmit});

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  late final TextEditingController _nameController = TextEditingController(
    text: widget.existing?.name ?? '',
  );
  String _selectedType = 'Cash';
  String _amount = '';

  // Add controller for the draggable sheet
  late DraggableScrollableController _dragController;
  double _currentSize = 0.7;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _dragController = DraggableScrollableController();

    // Set existing values
    if (widget.existing != null) {
      _selectedType = widget.existing!.type;
      _amount = widget.existing!.balance.toString();
    }

    // Listen to sheet size changes
    _dragController.addListener(() {
      if (!_isDragging && _dragController.size < 0.3) {
        // Auto-close if dragged below threshold
        _closeSheet();
      }
      setState(() {
        _currentSize = _dragController.size;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dragController.dispose();
    super.dispose();
  }

  void _closeSheet() {
    if (mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final text1 = isDark ? Colors.white : Colors.black;
    final text2 = isDark ? Colors.grey[500]! : Colors.grey[700]!;
    final accent = const Color(0xFF007AFF);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          // Close sheet when tapping outside
          FocusScope.of(context).unfocus();
          _closeSheet();
        },
        child: DraggableScrollableSheet(
          controller: _dragController,
          initialChildSize: 0.9,
          minChildSize: 0.2,
          maxChildSize: 0.90,
          snap: true,
          snapSizes: const [0.2, 0.5, 0.8],
          builder: (context, scrollController) {
            return GestureDetector(
              // Prevent closing when tapping inside the sheet
              onTap: () {},
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    _isDragging = true;
                  } else if (notification is ScrollEndNotification) {
                    _isDragging = false;
                    // Check if should auto-close after scroll ends
                    if (_currentSize < 0.3) {
                      Future.delayed(Duration(milliseconds: 100), () {
                        if (mounted) _closeSheet();
                      });
                    }
                  }
                  return false;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.5 : 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Enhanced handle bar with close button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Close button
                                GestureDetector(
                                  onTap: _closeSheet,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: text2.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 20,
                                      color: text2,
                                    ),
                                  ),
                                ),

                                // Drag handle
                                Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: text2.withOpacity(0.35),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),

                                // Empty space for symmetry
                                SizedBox(width: 36),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.existing == null
                                  ? 'New Account'
                                  : 'Edit Account',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: text1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Drag handle or swipe down to close',
                              style: TextStyle(
                                fontSize: 12,
                                color: text2.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Content
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            // Account Name
                            _buildNameField(surface, text1, text2, accent),
                            const SizedBox(height: 14),

                            // Account Type
                            _buildTypeSelector(surface, text1, text2, accent),
                            const SizedBox(height: 18),

                            // Opening Balance
                            Text(
                              'Opening Balance',
                              style: TextStyle(
                                fontSize: 14,
                                color: text2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Amount Display
                            Text(
                              '₹${_formatAmount(_amount)}',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w200,
                                color: _getAmountColor(),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),

                            // Keypad
                            _buildKeypad(surface, text1, text2, accent),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNameField(Color surface, Color t1, Color t2, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Name',
          style: TextStyle(
            fontSize: 14,
            color: t2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: TextField(
            controller: _nameController,
            style: TextStyle(fontSize: 16, color: t1),
            decoration: InputDecoration(
              hintText: 'e.g., Main Wallet, Bank Account',
              hintStyle: TextStyle(color: t2.withOpacity(0.6)),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector(Color surface, Color t1, Color t2, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Type',
          style: TextStyle(
            fontSize: 14,
            color: t2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              _typeButton('Cash', Icons.payments_outlined, surface, t1, accent),
              _typeButton(
                'Bank',
                Icons.account_balance_outlined,
                surface,
                t1,
                accent,
              ),
              _typeButton(
                'Wallet',
                Icons.account_balance_wallet_outlined,
                surface,
                t1,
                accent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _typeButton(
    String text,
    IconData icon,
    Color surface,
    Color t1,
    Color accent,
  ) {
    final isSelected = _selectedType == text;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = text),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? accent.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? accent : t1.withOpacity(0.6),
              ),
              const SizedBox(height: 4),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? accent : t1.withOpacity(0.6),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Keypad similar to AddTransactionPage
  Widget _buildKeypad(Color surface, Color t1, Color t2, Color accent) {
    return Column(
      children: [
        // Row 1 & 2 with backspace
        SizedBox(
          height: 116,
          child: Row(
            children: [
              // Numbers column (1-6)
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: ['1', '2', '3'].map((key) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton(key, t1, accent),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: ['4', '5', '6'].map((key) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton(key, t1, accent),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              // Backspace button
              SizedBox(
                width: 70,
                child: GestureDetector(
                  onTap: () {
                    if (_amount.isNotEmpty) {
                      setState(
                        () =>
                            _amount = _amount.substring(0, _amount.length - 1),
                      );
                    }
                  },
                  child: Container(
                    height: 116,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.backspace_outlined,
                        color: accent,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Row 3 & 4 with save button
        SizedBox(
          height: 116,
          child: Row(
            children: [
              // Numbers column (7-0 and decimal)
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: ['7', '8', '9'].map((key) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton(key, t1, accent),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton('0', t1, accent),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: _keypadButton('.', t1, accent),
                            ),
                          ),
                          // Clear button
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                              ),
                              child: GestureDetector(
                                onTap: () => setState(() => _amount = ''),
                                child: Container(
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'C',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: accent,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              // Save button
              SizedBox(
                width: 70,
                child: GestureDetector(
                  onTap: () {
                    if (_canSave()) _saveAccount();
                  },
                  child: Container(
                    height: 116,
                    decoration: BoxDecoration(
                      color: _canSave() ? accent : accent.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 32),
                        const SizedBox(height: 4),
                        Text(
                          widget.existing == null ? 'Create' : 'Update',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _keypadButton(String key, Color t1, Color accent) {
    return GestureDetector(
      onTap: () {
        if (key == '.' && _amount.contains('.')) return;
        setState(() => _amount += key);
      },
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            key,
            style: TextStyle(
              fontSize: 20,
              color: t1,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Color _getAmountColor() {
    final amount = double.tryParse(_amount) ?? 0.0;
    if (amount == 0) return Colors.grey;
    return amount > 0 ? const Color(0xFF34C759) : const Color(0xFFFF3B30);
  }

  String _formatAmount(String a) {
    if (a.isEmpty) return '0.00';
    final val = double.tryParse(a);
    if (val == null) return a;
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String formatted = val.toStringAsFixed(2);
    return formatted.replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }

  bool _canSave() {
    return _nameController.text.trim().isNotEmpty &&
        _amount.isNotEmpty &&
        double.tryParse(_amount) != null;
  }

  void _saveAccount() {
    if (!_canSave()) return;

    final account = Account(
      id: widget.existing?.id ?? const Uuid().v4(),
      name: _nameController.text.trim(),
      balance: double.tryParse(_amount) ?? 0.0,
      type: _selectedType,
      role: AccountRole.both,
    );

    widget.onSubmit(account);
    Navigator.of(context).pop();
  }
}
