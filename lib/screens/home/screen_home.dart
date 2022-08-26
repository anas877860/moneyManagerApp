import 'package:flutter/material.dart';


import 'package:money_manager_flutter/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_manager_flutter/screens/catergory/category_add_popup.dart';
import 'package:money_manager_flutter/screens/catergory/screen_category.dart';
import 'package:money_manager_flutter/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager_flutter/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
 const  ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _page = const [ScreenTransactions(),  ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("MONEY MANAGER"),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext ctx, int updatedIndex, Widget? _) {
            return _page[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            // print("add Transactions");
            Navigator.pushNamed(context, ScreenAddTransaction.routName);
          } else {
            // print("add Category");
            showCategoryAddPopup(context);
            // final _sample = CategoryModel(
            //     name: "Travel",
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     type: CategoryType.expense);
            //     CategoryDB().insertCategory(_sample);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
