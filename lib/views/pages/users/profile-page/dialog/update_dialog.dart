import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/districts_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/helper_functions.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/district_dropdown.dart';
import '../../../../widgets/division_dropdown.dart';
import '../../../../widgets/loading_widget.dart';

updateDialog({required BuildContext context, required String key}) {
  TextEditingController textEditingController = TextEditingController();
  final userProvider = context.read<UserProvider>();
  final disProvider = context.read<DistrictsProvider>();

  customTextField() {
    return CustomFormField(
      controller: textEditingController,
      labelText: key[0].toUpperCase() + key.substring(1).toLowerCase(),
      isPrefIcon: false,
      textInputType: key == 'mobile' ? TextInputType.phone : TextInputType.text,
      maxLine: key == 'about' ? 4 : 1,
    );
  }

  addressDropdown() {
    context.read<DistrictsProvider>().getAllDivision();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        DivisionDropDown(),
        DistrictDropDown(),
      ],
    );
  }

  genderRadioBtn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) => Radio<String>(
                value: 'male',
                groupValue: userProvider.genderGroupValue,
                onChanged: (value) {
                  userProvider.setGenderGroupValue(value!);
                },
              ),
            ),
            const Text('Male'),
          ],
        ),
        Row(
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) => Radio<String>(
                value: 'female',
                groupValue: userProvider.genderGroupValue,
                onChanged: (value) {
                  userProvider.setGenderGroupValue(value!);
                },
              ),
            ),
            const Text('Female'),
          ],
        ),
      ],
    );
  }

  setContent() {
    if (key == 'gender') {
      return genderRadioBtn();
    } else if (key == 'address') {
      return addressDropdown();
    }

    if (key == 'about' && context.read<UserProvider>().user!.about != null) {
      textEditingController.text = context.read<UserProvider>().user!.about!;
    }
    if (key == 'mobile' &&
        context.read<UserProvider>().user!.mobile!.number != null) {
      textEditingController.text =
          context.read<UserProvider>().user!.mobile!.number!;
    }
    return customTextField();
  }

  setDob() async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (dateTime != null) {
      userProvider.updateUser(
          {key: dateTime.millisecondsSinceEpoch}, userProvider.user!.id!);
    }
  }

  saveData() async {
    if (key == 'gender' && userProvider.genderGroupValue != null) {
      await userProvider.updateUser(
          {key: userProvider.genderGroupValue}, userProvider.user!.id!);
      return;
    } else if (key == 'address' &&
        disProvider.division != null &&
        disProvider.district != null) {
      await userProvider.updateUser({
        'division': disProvider.division?.division,
        'district': disProvider.district?.district
      }, userProvider.user!.id!);
      return;
    }

    if (key == 'mobile') {
      RegExp pattern = RegExp(r'(^(\+88)?(01){1}[3456789]{1}(\d){8})$');
      if (pattern.hasMatch(textEditingController.text)) {
        await userProvider.updateUser({
          key: {'number': textEditingController.text}
        }, userProvider.user!.id!);
      }else{
        // ignore: use_build_context_synchronously
        showMsg(context, 'Please enter mobile number');
      }

      return;
    }

    await userProvider
        .updateUser({key: textEditingController.text}, userProvider.user!.id!);
  }

  return key == 'dob'
      ? setDob()
      : showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text(key.toUpperCase()),
            content: setContent(),
            actions: [
              TextButton(
                onPressed: () {
                  disProvider.reset();
                  Navigator.pop(context);
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  showLoadingDialog(context);
                  saveData();
                  disProvider.reset();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('UPDATE'),
              ),
            ],
          ),
        );
}
