import 'package:derbymatch/core/common/widgets/selectAddress/models/address_model.dart';
import 'package:derbymatch/core/common/widgets/selectAddress/widgets/address_item_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/pallete.dart';
import '../../../core/values/values.dart';
import '../../auth/controllers/user_me_controller.dart';
import '../../auth/models/user_model.dart';
import '../screens/success_user_profile_screen.dart';

class AddressFormWidget extends ConsumerStatefulWidget {
  final goNextPage;
  final goPrevPage;
  final done;

  const AddressFormWidget({
    required this.goNextPage,
    required this.goPrevPage,
    this.done,
    super.key,
  });

  @override
  ConsumerState<AddressFormWidget> createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends ConsumerState<AddressFormWidget> {
  FocusNode textFocus = FocusNode();
  late final TextEditingController addressEditController;
  String? address_code;

  @override
  void initState() {
    super.initState();
    final userModel = ref.read(userMeProvider) as UserModel;
    address_code = userModel.addressCode;
    addressEditController = TextEditingController(text: userModel.addressName);
  }

  Future<List> _addressList() async {
    final dio = Dio();

    final resp = await dio.get(
      Constants.ip + '/common/getAddressList/' + '__00000000',
      options: Options(
        headers: {},
      ),
    );
    return resp.data;
  }

  Future<List> _addressSecondList(String uppAddressCode) async {
    final dio = Dio();

    final resp = await dio.get(
      Constants.ip +
          '/common/getAddressList/' +
          uppAddressCode +
          '__' +
          '000000',
      options: Options(
        headers: {},
      ),
    );
    return resp.data;
  }

// AddressItemWidget 탭 이벤트 처리
  void _handleAddressItemTap(String uppAddressCode) {
    // Navigator.pop(context); // 현재 Dialog 닫기
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // 선택한 주소에 대한 추가 정보를 보여주는 새로운 Dialog 구현
        return Dialog(
          backgroundColor: Pallete.whiteColor,
          elevation: 0,
          insetPadding: EdgeInsets.all(0), // 전체 화면으로 확장
          child: Container(
            width: MediaQuery.of(context).size.width, // 화면 너비만큼 설정
            height: MediaQuery.of(context).size.height, // 화면 높이만큼 설정
            child: Padding(
              padding: EdgeInsets.all(AppSpaceSize.mediumSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('주소를 선택해주세요.',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.headlineTextStyle),
                  ),
                  Expanded(
                    flex: 9,
                    child: FutureBuilder<List>(
                      future: _addressSecondList(uppAddressCode),
                      builder: (context, AsyncSnapshot<List> snapshot) {
                        if (!snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('불러오는중 입니다.'),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
                          child: GridView.builder(
                            shrinkWrap: true,
                            // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
                            itemCount: snapshot.data!.length,
                            //item 개수
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              //1 개의 행에 보여줄 item 개수
                              childAspectRatio: 1 / 1,
                              //item 의 가로 세로의 비율
                              mainAxisSpacing: AppSpaceSize.smallSize,
                              //수평 Padding
                              crossAxisSpacing:
                                  AppSpaceSize.smallSize, //수직 Padding
                            ),
                            itemBuilder: (_, index) {
                              //!연산자는 null이 아니라고 단언 하는것 스크립트 에러를 막기위해서
                              final item = snapshot.data![index];

                              final pItem = AddressModel.fromMap(item);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    address_code = pItem.address_code;
                                    addressEditController.text =
                                        pItem.address_name;

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                },
                                child: AddressItemWidget.fromModel(
                                  model: pItem,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "이전",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSelectAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Pallete.whiteColor,
          elevation: 0,
          insetPadding: EdgeInsets.all(0), // 전체 화면으로 확장
          child: Container(
            width: MediaQuery.of(context).size.width, // 화면 너비만큼 설정
            height: MediaQuery.of(context).size.height, // 화면 높이만큼 설정
            child: Padding(
              padding: EdgeInsets.all(AppSpaceSize.mediumSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('주소를 선택해주세요.',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.headlineTextStyle),
                  ),
                  Expanded(
                    flex: 9,
                    child: FutureBuilder<List>(
                      future: _addressList(),
                      builder: (context, AsyncSnapshot<List> snapshot) {
                        if (!snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('불러오는중 입니다.'),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.all(AppSpaceSize.mediumSize),
                          child: GridView.builder(
                            shrinkWrap: true,
                            // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
                            itemCount: snapshot.data!.length,
                            //item 개수
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              //1 개의 행에 보여줄 item 개수
                              childAspectRatio: 1 / 1,
                              //item 의 가로 세로의 비율
                              mainAxisSpacing: AppSpaceSize.smallSize,
                              //수평 Padding
                              crossAxisSpacing:
                                  AppSpaceSize.smallSize, //수직 Padding
                            ),
                            itemBuilder: (_, index) {
                              //!연산자는 null이 아니라고 단언 하는것 스크립트 에러를 막기위해서
                              final item = snapshot.data![index];

                              final pItem = AddressModel.fromMap(item);
                              return GestureDetector(
                                onTap: () {
                                  _handleAddressItemTap(
                                      pItem.address_code.substring(0, 2));
                                },
                                child: AddressItemWidget.fromModel(
                                  model: pItem,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "닫기",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    textFocus.dispose();
    addressEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.read(userMeProvider) as UserModel;

    return GestureDetector(
      onTap: () {
        textFocus.unfocus();
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text('${userModel.name}님 활동 지역은 어디신가요?',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.headlineTextStyle),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: _showSelectAddressDialog,
                child: AbsorbPointer(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: addressEditController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: '지역을 선택해 주세요',
                    ),
                    focusNode: textFocus,
                    style: AppTextStyles.headlineTextStyle,
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        widget.goPrevPage();
                      },
                      child: Text("이전",
                          style: AppTextStyles.bodyTextStyle
                              .copyWith(color: Pallete.primaryColor)),
                      style: ButtonStyles.seconderyButton,
                    ),
                  ),
                  AppSpacesBox.horizontalSpaceSmall,
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          UserModel updatedUser = await ref
                              .read(userMeProvider.notifier)
                              .editUserModel(
                                isSave: true,
                                userModel: userModel.copyWith(
                                  addressCode: address_code,
                                  addressName: addressEditController.text,
                                ),
                              );
                          // API 호출 성공, 성공 페이지로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessUserProfileScreen(),
                            ), // SuccessPage는 성공 시 보여줄 페이지
                          );
                        } catch (e) {
                          // 에러 처리
                          print('API 호출 실패: $e');
                        }
                      },
                      child: Text(
                        "완료",
                        style: AppTextStyles.bodyTextStyle
                            .copyWith(color: Pallete.whiteColor),
                      ),
                      style: ButtonStyles.primaryButton,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSpaceSize.xlargeSize,
            ),
          ],
        ),
      ),
    );
  }
}
