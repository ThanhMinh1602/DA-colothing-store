class BankCardModel {
  final String id;
  final String bankNumber;
  final String bankIcon;

  BankCardModel({
    required this.id,
    required this.bankNumber,
    required this.bankIcon,
  });
}

final List<BankCardModel> bankCards = [
  BankCardModel(
    id: '1',
    bankNumber: '**** **** **** 2143',
    bankIcon:
        'https://ruybangphuonghoang.com/wp-content/uploads/2024/10/VIETCOMBANKLOGO-1240x800.jpg',
  ),

  BankCardModel(
    id: '3',
    bankNumber: '**** **** **** 6321',
    bankIcon:
        'https://forbes.vn/wp-content/uploads/2022/08/LogoTop25tc_vpbank.jpg',
  ),
  BankCardModel(
    id: '4',
    bankNumber: '**** **** **** 4567',
    bankIcon:
        'https://bidv.com.vn/wps/wcm/connect/50809043-c9b7-40e9-9d5c-a419caca1b79/Logo+Nguyen+nen+xanh.png?MOD=AJPERES&CACHEID=ROOTWORKSPACE-50809043-c9b7-40e9-9d5c-a419caca1b79-pfdjkOq',
  ),
  BankCardModel(
    id: '5',
    bankNumber: '**** **** **** 9912',
    bankIcon:
        'https://cdn2.fptshop.com.vn/unsafe/Uploads/images/tin-tuc/177929/Originals/app-mb-bi-loi-1.png',
  ),
];
