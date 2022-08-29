import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class PhoneContacts extends StatefulWidget {
  const PhoneContacts({Key? key}) : super(key: key);

  @override
  _PhoneContactsState createState() => _PhoneContactsState();
}

class _PhoneContactsState extends State<PhoneContacts> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  bool? checkedValue = false;
  bool? newValue = false;
  String? name;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _body() {
      if (_permissionDenied) {
        return const Center(child: Text('Permission denied'));
      }
      if (_contacts == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.separated(
          separatorBuilder: (context, index) => const SpaceDivider(
                height: 20,
              ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _contacts!.length,
          itemBuilder: (context, i) {
            return CheckboxListTile(
              activeColor: secondaryColor,
                title: Row(
                  children: [
                    CircleAvatar(
                      child: Text('${_contacts![i].displayName[0]} '),
                    ),
                    kSmallWidth,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_contacts![i].displayName),
                        Text(_contacts![i].phones.isEmpty
                            ? '+234 7003506784'
                            : _contacts![i].phones[0].number),
                      ],
                    )
                  ],
                ),
                value: name == _contacts![i].displayName && !newValue! ? checkedValue : newValue,
                onChanged: (bool? newValue) {
                  setState(() {
                    checkedValue = newValue;
                    name = _contacts![i].displayName;
                  });
                });
          });
    }

    return Column(
      children: [
        Padding(
          padding: defaultHPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  'Share to contacts',
                  style: textStyle400Small,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Select All',
                    style: textStyleSecondary,
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: () {
                      setState(() {
                        newValue = !newValue!;
                      });
                    },
                    child: newValue!
                        ? Icon(Icons.check_box, color: secondaryColor)
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: blackColor.withOpacity(0.5),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
        kSmallHeight,
        SizedBox(height: 800, child: _body())
      ],
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage(this.contact, {Key? key}) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text(
            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));
}
