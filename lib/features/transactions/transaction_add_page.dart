import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_project/core/models/transaction_model.dart';
import 'package:expense_project/core/models/account_model.dart';
import 'package:expense_project/core/models/category_model.dart';
import 'package:expense_project/features/accounts/accounts_provider.dart';
import 'package:expense_project/features/categories/categories_provider.dart';
import 'package:expense_project/features/transactions/transactions_provider.dart';

class AddTransactionPage extends ConsumerStatefulWidget {
  const AddTransactionPage({super.key});

  @override
  ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
  TransactionType _selectedType = TransactionType.expense;
  String? _selectedAccount;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  String _amount = '';
  final TextEditingController _commentController = TextEditingController();

  // Add controller for the draggable sheet
  late DraggableScrollableController _dragController;
  double _currentSize = 0.9;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _dragController = DraggableScrollableController();

    // Listen to sheet size changes
    _dragController.addListener(() {
      if (!_isDragging && _dragController.size < 0.4) {
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
    _commentController.dispose();
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

    final accountsAsync = ref.watch(accountsProvider);
    final categoriesAsync = _selectedType == TransactionType.expense
        ? ref.watch(expenseCategoriesProvider)
        : ref.watch(incomeCategoriesProvider);

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
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.2, 0.6, 0.9],
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
                    if (_currentSize < 0.4) {
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
                              'Add Transaction',
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
                            // Account & Category
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAccountDropdown(
                                    accountsAsync,
                                    surface,
                                    text1,
                                    text2,
                                    accent,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _buildCategoryDropdown(
                                    categoriesAsync,
                                    surface,
                                    text1,
                                    text2,
                                    accent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),

                            // Date + Toggle
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDateSelector(
                                    surface,
                                    text1,
                                    text2,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                _buildTypeToggle(
                                  _selectedType,
                                  accent,
                                  surface,
                                  text1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // Amount
                            Text(
                              '₹${_formatAmount(_amount)}',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w200,
                                color: _selectedType == TransactionType.expense
                                    ? const Color(0xFFFF3B30)
                                    : const Color(0xFF34C759),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),

                            // Comment
                            _buildCommentField(text2),
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

  // Account Dropdown
  Widget _buildAccountDropdown(
    AsyncValue<List<Account>> data,
    Color surface,
    Color t1,
    Color t2,
    Color accent,
  ) {
    return data.when(
      loading: () => _loadingTile('Account', surface, t2),
      error: (_, __) => _errorTile(surface, t2),
      data: (accounts) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: surface,
              value: _selectedAccount,
              hint: Text('Account (Optional)', style: TextStyle(color: t2)),
              isExpanded: true,
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('No Account', style: TextStyle(color: t2)),
                ),
                ...accounts.map((acc) {
                  return DropdownMenuItem(
                    value: acc.name,
                    child: Text(acc.name, style: TextStyle(color: t1)),
                  );
                }).toList(),
              ],
              onChanged: (val) {
                setState(() => _selectedAccount = val);
              },
            ),
          ),
        );
      },
    );
  }

  // Category Dropdown
  Widget _buildCategoryDropdown(
    AsyncValue<List<dynamic>> data,
    Color surface,
    Color t1,
    Color t2,
    Color accent,
  ) {
    return data.when(
      loading: () => _loadingTile('Category', surface, t2),
      error: (_, __) => _errorTile(surface, t2),
      data: (categories) {
        List<String> names = categories.map((c) {
          if (c is ExpenseCategory) return c.name;
          if (c is IncomeCategory) return c.name;
          return c.toString();
        }).toList();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: surface,
              value: _selectedCategory,
              hint: Text('Category (Optional)', style: TextStyle(color: t2)),
              isExpanded: true,
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('No Category', style: TextStyle(color: t2)),
                ),
                ...names.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat, style: TextStyle(color: t1)),
                  );
                }).toList(),
              ],
              onChanged: (val) {
                setState(() {
                  _selectedCategory = val;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateSelector(Color surface, Color t1, Color t2) {
    return GestureDetector(
      onTap: _selectDate,
      child: _dropdownTile(
        _formatDate(_selectedDate),
        Icons.calendar_today,
        surface,
        t1,
        t2,
        const Color(0xFF007AFF),
        selected: true,
      ),
    );
  }

  Widget _buildTypeToggle(
    TransactionType type,
    Color accent,
    Color surface,
    Color t1,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleBtn(
            'Expense',
            Icons.arrow_downward,
            type == TransactionType.expense,
            () {
              setState(() {
                _selectedType = TransactionType.expense;
                _selectedCategory = null;
              });
            },
            accent,
            t1,
          ),
          _toggleBtn(
            'Income',
            Icons.arrow_upward,
            type == TransactionType.income,
            () {
              setState(() {
                _selectedType = TransactionType.income;
                _selectedCategory = null;
              });
            },
            accent,
            t1,
          ),
        ],
      ),
    );
  }

  Widget _toggleBtn(
    String text,
    IconData icon,
    bool sel,
    VoidCallback onTap,
    Color accent,
    Color t1,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: sel ? accent.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: sel ? accent : t1.withOpacity(0.6)),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: sel ? accent : t1.withOpacity(0.6),
                fontWeight: sel ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentField(Color t2) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: TextField(
        controller: _commentController,
        textAlign: TextAlign.center,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Add comment...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: t2, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        style: TextStyle(fontSize: 14, color: t2),
      ),
    );
  }

  // Simplified Keypad - No X button, no hold for date
  Widget _buildKeypad(Color surface, Color t1, Color t2, Color accent) {
    return Column(
      children: [
        // Row 1 & 2 with simplified backspace
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
              // Simplified backspace button
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
        // Row 3 & 4 with save button (no X button)
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
                          // Empty space where X button was
                          Expanded(child: Container()),
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
                    if (_canSave()) _saveTransaction();
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
                          'Save',
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

  Widget _dropdownTile(
    String text,
    IconData icon,
    Color surface,
    Color t1,
    Color t2,
    Color accent, {
    VoidCallback? onTap,
    bool selected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: (selected ? accent : t2).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: selected ? accent : t2),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? t1 : t2,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (onTap != null)
              Icon(Icons.keyboard_arrow_down, size: 16, color: t2),
          ],
        ),
      ),
    );
  }

  Widget _loadingTile(String l, Color surface, Color t2) =>
      _dropdownTile(l, Icons.hourglass_empty, surface, t2, t2, t2);

  Widget _errorTile(Color surface, Color t2) =>
      _dropdownTile('Error', Icons.error, surface, t2, t2, t2);

  String _formatAmount(String a) {
    if (a.isEmpty) return '0.00';
    final val = double.tryParse(a);
    if (val == null) return a;
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String formatted = val.toStringAsFixed(2);
    return formatted.replaceAllMapped(formatter, (Match m) => '${m[1]},');
  }

  String _formatDate(DateTime d) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  bool _canSave() =>
      _amount.isNotEmpty &&
      double.tryParse(_amount) != null &&
      double.parse(_amount) > 0;

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveTransaction() async {
    if (!_canSave()) {
      // Show specific error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid amount greater than 0'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      final tx = TransactionModel(
        id: const Uuid().v4(),
        type: _selectedType,
        date: _selectedDate,
        title: _commentController.text.isNotEmpty
            ? _commentController.text
            : '${_selectedType.name.capitalize()} Transaction',
        amount: double.parse(_amount),
        account: _selectedAccount, // Can be null
        category: _selectedCategory, // Can be null
        note: _commentController.text.isEmpty ? null : _commentController.text,
      );

      await ref.read(transactionsProvider.notifier).addTransaction(tx);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaction saved successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error saving transaction: $e'); // Debug info
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving transaction: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

extension StringCapitalization on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
