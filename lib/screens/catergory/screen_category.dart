import 'package:flutter/material.dart';

import 'package:money_manager_flutter/screens/catergory/expense_category_list.dart';
import 'package:money_manager_flutter/screens/catergory/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple])), //Change back
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'INCOME',
                ),
                Tab(
                  text: 'EXPENSE',
                ),
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              IncomeCategoryList(),
              ExpenseCategoryList(),
            ]),
          )
        ],
      ),
    );
  }
}
