import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/symbols.dart';

class ReportsPage extends StatelessWidget {
  static const String routeName = '/order';
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Today',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Order'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Total order'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Total Sale'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$currencySymbol sale price'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => null,
                    // Navigator.pushNamed(
                    //     context, OrderListPage.routeName,
                    //     arguments: OrderFilter.TODAY),
                    child: const Text('View All'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Yesterday',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Order'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Total order'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Total Sale'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$currencySymbol total sale'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => null,
                    child: const Text('View All'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Last 7 days',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Order'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Total Order'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Total Sale'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$currencySymbol Total Order'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => null,
                    child: const Text('View All'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'This Month',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Order'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Total Order'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Total Sale'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '$currencySymbol Total Order'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => null,
                    child: const Text('View All'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'All Time',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text('Total Order'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Total Order'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Total Sale'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '$currencySymbol Total Order'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => null,
                    child: const Text('View All'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
