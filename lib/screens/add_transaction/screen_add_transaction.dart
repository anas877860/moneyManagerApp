import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/db/transaction/transaction_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';
import 'package:money_manager_flutter/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routName = 'add-transaction';

  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectDate;
  CategoryType? _selectCategoryType;
  CategoryModel? _selectCategoryModel;
  String? _categoryID;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  @override
  void initState() {
    _selectCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _purposeTextEditingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
              controller: _amountTextEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now());
                if (_selectDateTemp == null) {
                  return;
                } else {
                  // print(_selectDateTemp.toString());
                  setState(() {
                    _selectDate = _selectDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(
                  _selectDate == null ? 'Select Date' : _selectDate.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio<CategoryType>(
                        value: CategoryType.income,
                        groupValue: _selectCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectCategoryType = CategoryType.income;
                            _categoryID = null;
                          });
                        }),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio<CategoryType>(
                        value: CategoryType.expense,
                        groupValue: _selectCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectCategoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        }),
                    const Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
                value: _categoryID,
                hint: const Text('Select Category'),
                items: (_selectCategoryType == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB().expenseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    onTap: () {
                      _selectCategoryModel = e;
                    },
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    _categoryID = selectedValue;
                  });
                }),
            ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: const Text('submit'))
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }

    if (_selectDate == null) {
      return;
    }

    if (_selectCategoryType == null) {
      return;
    }
    if (_selectCategoryModel == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectDate!,
      type: _selectCategoryType!,
      category: _selectCategoryModel!,
    );
    TransactionDB.instance.addTransaction(_model);
    Navigator.pop(context);
    TransactionDB.instance.refresh();
  }
}
