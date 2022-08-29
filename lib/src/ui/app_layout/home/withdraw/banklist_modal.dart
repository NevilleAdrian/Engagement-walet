import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/values/fonts.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/radii.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

typedef BankListCallback(int index, String bankName);

class BankListModal extends StatefulWidget {
  final BankListCallback frequencyCallback;
  final List<String> _freqList;

  BankListModal(this._freqList, this.frequencyCallback);

  @override
  State<BankListModal> createState() => _BankListModalState();
}

class BankResponse {
}

class _BankListModalState extends State<BankListModal> {
  TextEditingController textEditingController = TextEditingController();

  List<String> _freqList = [];

  @override
  void initState() {
    super.initState();
    _freqList = widget._freqList;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    var shortestSide = mediaQuery.size.shortestSide;


    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: Radii.k20TopSymmetricRadius),
          child: Container(
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: Radii.k20TopSymmetricRadius),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: defaultPadding,
                  child: EditTextSignUp(
                    controller: textEditingController,
                    validatorCallback: formValidatorBloc.singleInputValidator,
                    labelText: null,
                    prefix: Icon(
                      Icons.search,
                      color: secondaryColor,
                    ),
                    hintText: 'Search Banks',
                    textAlignVertical: TextAlignVertical.center,
                    textInputType: TextInputType.text,
                    onChangedCallback: (String value) => setState(() =>
                    _freqList = widget._freqList
                        .where((element) => element
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList()), text: '',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: _freqList.length,
                    padding: defaultPadding,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        close(context);
                        widget.frequencyCallback(
                            index, _freqList.elementAt(index));
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            _freqList.elementAt(index),
                            style: textStyle400Small,

                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  close(context) {
    Navigator.pop(context);
  }
}
