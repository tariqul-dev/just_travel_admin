import 'package:flutter/material.dart';
import 'package:just_travel_admin/providers/payment_provider.dart';
import 'package:just_travel_admin/utils/constants/symbols.dart';
import 'package:just_travel_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';

class PaymentsPage extends StatelessWidget {
  static const routeName = '/payments';
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        context.read<PaymentProvider>().fetchAllPaymentInfo();
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: Center(
        child: Consumer<PaymentProvider>(
          builder: (context, payProvider, child) {
            return payProvider.allPaymentList.isEmpty
                ? const Text('Empty Payment Info')
                : ListView.builder(
                    itemCount: payProvider.allPaymentList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(
                            '${payProvider.allPaymentList[index].userId!.name}',
                          ),
                          subtitle: Text(
                            'Trip: ${payProvider.allPaymentList[index].tripId!.placeName}\n'
                            'Mobile: ${payProvider.allPaymentList[index].mobileNumber}\n'
                            'Transaction ID: ${payProvider.allPaymentList[index].tranId}\n'
                            'Date: ${getFormattedDateTime(dateTime: DateTime.parse(payProvider.allPaymentList[index].createdAt!).millisecondsSinceEpoch, pattern: 'MMM dd yyyy')}\n'
                            'Status: ${payProvider.allPaymentList[index].status == 'VALID' ? 'Paid' : payProvider.allPaymentList[index].status}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor:
                                payProvider.allPaymentList[index].status ==
                                        'VALID'
                                    ? Colors.green
                                    : Colors.red,
                            radius: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                    '$currencySymbol${payProvider.allPaymentList[index].amount}'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
