import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:money_manager_flutter/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_manager_flutter/screens/catergory/category_add_popup.dart';
import 'package:money_manager_flutter/screens/catergory/screen_category.dart';
import 'package:money_manager_flutter/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager_flutter/screens/sign_in_screen/sign_in_screen.dart';
import 'package:money_manager_flutter/screens/transactions/screen_transactions.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _page = const [ScreenTransactions(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text("MONEY MANAGER"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  log("Sign out");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (route) => false);
                });
              },
              icon: const Icon(Icons.logout))
        ],
        gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple, Colors.red]),
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
        child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: const Icon(
              Icons.add,
              size: 40,
            )),
      ),
    );
  }
}
