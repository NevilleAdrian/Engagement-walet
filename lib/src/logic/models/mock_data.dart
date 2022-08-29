import 'dart:core';


class BanksDatum {
  BanksDatum({
    this.id,
    this.bankName,
    this.bankCode,
  });

  final String? id;
  final String? bankName;
  final String? bankCode;


  factory BanksDatum.fromJson(Map<String, dynamic> json) => BanksDatum(
    id: json["id"] == null ? null : json["id"],
    bankName: json["bankName"] == null ? null : json["bankName"],
    bankCode: json["bankCode"] == null ? null : json["bankCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bankName": bankName == null ? null : bankName,
    "bankCode": bankCode == null ? null : bankCode,

  };
}

final List<Map<String, String>> bankData = [
  {
    "id": '1',
    "bankName": 'Access bank',
    "bankCode": '001',
    "customerName": 'Chukumah Neville',
    "accountNumber": '0005875855',
  },
  {
    "id": '2',
    "bankName": 'GT bank',
    "bankCode": '001',
    "customerName": 'Adolphus Benjamin',
    "accountNumber": '0005858555',
  },
  {
    "id": '3',
    "bankName": 'Fidelity bank',
    "bankCode": '001',
    "customerName": 'Collin Felix',
    "accountNumber": '000675855',
  },
  {
    "id": '4',
    "bankName": 'Standard Chartered bank',
    "bankCode": '001',
    "customerName": 'Richard Bradson',
    "accountNumber": '000586958',
  },
];

final List<Map<String, dynamic>> transactionHistory = [
  {
    "type": "Wallet Top-up",
    "date": "May 31",
    "amount": 500,
  },
  {
    "type": "Store Purchase",
    "date": "May 23",
    "amount": 1500,
  },
  {
    "type": "Wallet Top-up",
    "date": "May 31",
    "amount": 500,
  },
  {
    "type": "Store Purchase",
    "date": "May 23",
    "amount": 3500,
  },
];

final List<Map<String, dynamic>> orderHistory = [
  {
    "address": "JAN 01, 2021",
    "status": "delivered",
    "item": "Women Tops Solid Color",
    "amount": 500,
    "quantity": 2
  },
  {
    "address": "JAN 01, 2021",
    "status": "delivered",
    "item": "Women Tops Solid Color",
    "amount": 500,
    "quantity": 2
  },
  {
    "address": "JAN 01, 2021",
    "status": "pending",
    "item": "Men's Sneakers",
    "amount": 1500,
    "quantity": 4
  },
  {
    "address": "8b Ademulegun street, Isolo, Lagos",
    "status": "failed",
    "item": "Cartier wristwatch",
    "amount": 900,
    "quantity": 1
  },
  {
    "address": "Close 3 Westend Estate, Ikota, Lekky county",
    "status": "pending",
    "item": "Men's Sneakers",
    "amount": 1500,
    "quantity": 4
  },
  {
    "address": "22a Professor Kiumiu Akingbehin Street, Lekki Phase 1",
    "status": "delivered",
    "item": "Women Tops Solid Color",
    "amount": 500,
    "quantity": 2
  },
  {
    "address": "8b Ademulegun street, Isolo, Lagos",
    "status": "failed",
    "item": "Cartier wristwatch",
    "amount": 900,
    "quantity": 1
  },
];

final List<Map<String, dynamic>> shopData = [
  {
    "id": '1',
    "amount": 200000,
    "title": 'Playstation 4 Limited Edition (with games)',
    "description": 'Open repair of infrarenal aortic aneurysm or dissection, plus repair of associated arterial trauma, following unsuccessful endovascular repair; aorto-bi-iliac prosthesis ',
    "image": [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ]
  },
  {
    "id": '2',
    "amount": 500000,
    "title": 'Xbox 4 Limited Edition (with games)',
    "description": 'Open repair of infrarenal aortic aneurysm or dissection, plus repair of associated arterial trauma, following unsuccessful endovascular repair; aorto-bi-iliac prosthesis ',
    "image": [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ]
  },
  {
    "id": '3',
    "amount": 100000,
    "title": 'Iphone 12',
    "description": 'Open repair of infrarenal aortic aneurysm or dissection, plus repair of associated arterial trauma, following unsuccessful endovascular repair; aorto-bi-iliac prosthesis ',
    "image": [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ]
  },

];

final List<String> bankDetails = [
 "Bank Name",
 "Account Number",
 "Account Name",
 "Amount",
];

final List<String> bankTransfer = [
  "User Id",
  "Amount",
];

final List<Map<String, String>> friendList = [
  {
    "id": "1",
    "name": 'Kelechi Nwosu',
    "userName": 'Kelz',
  },
  {
    "id": "2",
    "name": 'Daniels Olakunle',
    "userName": 'dan007',
  },
  {
    "id": "3",
    "name": 'Tope Orodeji',
    "userName": 'top_boy',
  },
  {
    "id": "4",
    "name": 'Tife Balogun',
    "userName": 'tifebee',
  },
  {
    "id": "5",
    "name": 'Tife Balogun',
    "userName": 'tifebee',
  },
  {
    "id": "6",
    "name": 'Olawale Isreal',
    "userName": 'olaeee',
  },
  {
    "id": "7",
    "name": 'Promise Ejiofor',
    "userName": 'p4eji',
  },
];


List<BanksDatum> bankResponse  = (bankData).map((e) => BanksDatum.fromJson(e)).toList();
