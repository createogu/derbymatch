import 'package:derbymatch/core/common/widgets/selectAddress/models/address_model.dart';
import 'package:derbymatch/core/values/values.dart';
import 'package:flutter/material.dart';

import '../../../../theme/pallete.dart';

class AddressItemWidget extends StatelessWidget {
  final String address_code;
  final String address_name;

  const AddressItemWidget({
    required this.address_code,
    required this.address_name,
    Key? key,
  }) : super(key: key);

  factory AddressItemWidget.fromModel({
    required AddressModel model,
  }) {
    return AddressItemWidget(
      address_code: model.address_code,
      address_name: model.address_name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1,
            color: Pallete.seconderyColor,
          )),
      child: Center(
        child: Text(
          address_name.lastIndexOf(' ') != -1
              ? address_name.replaceRange(0, address_name.lastIndexOf(' '), '')
              : address_name,
          style: AppTextStyles.cautionTextStyle,
        ),
      ),
    );
  }
}
