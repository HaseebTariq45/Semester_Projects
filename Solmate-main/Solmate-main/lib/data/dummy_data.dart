import 'package:flutter/material.dart';

import '../models/models.dart';

final List<ShoeModel> availableShoes = [
  ShoeModel(
    name: "NIKE",
    model: "AIR-MAX",
    price: 130.00,
    imgAddress: "assets/images/nike1.png",
    modelColor: const Color(0xffDE0106),
  ),
  ShoeModel(
    name: "NIKE",
    model: "AIR-JORDAN MID",
    price: 190.00,
    imgAddress: "assets/images/nike8.png",
    modelColor: const Color(0xff3F7943),
  ),
  ShoeModel(
    name: "NIKE",
    model: "ZOOM",
    price: 160.00,
    imgAddress: "assets/images/nike2.png",
    modelColor: const Color(0xffE66863),
  ),
  ShoeModel(
    name: "NIKE",
    model: "Air-FORCE",
    price: 110.00,
    imgAddress: "assets/images/nike3.png",
    modelColor: const Color(0xffD7D8DC),
  ),
  ShoeModel(
    name: "NIKE",
    model: "AIR-JORDAN LOW",
    price: 150.00,
    imgAddress: "assets/images/nike5.png",
    modelColor: const Color(0xff37376B),
  ),
  ShoeModel(
    name: "NIKE",
    model: "ZOOM",
    price: 115.00,
    imgAddress: "assets/images/nike4.png",
    modelColor: const Color(0xffE4E3E8),
  ),
  ShoeModel(
    name: "NIKE",
    model: "AIR-JORDAN LOW",
    price: 150.00,
    imgAddress: "assets/images/nike7.png",
    modelColor: const Color(0xffD68043),
  ),
  ShoeModel(
    name: "NIKE",
    model: "AIR-JORDAN LOW",
    price: 150.00,
    imgAddress: "assets/images/nike6.png",
    modelColor: const Color(0xffE2E3E5),
  ),
  // Adidas Models
  ShoeModel(
    name: "ADIDAS",
    model: "ULTRABOOST",
    price: 180.00,
    imgAddress: "assets/images/adidas1.png",
    modelColor: const Color(0xffE5E5E5),
  ),
  ShoeModel(
    name: "ADIDAS",
    model: "NMD_R1",
    price: 140.00,
    imgAddress: "assets/images/adidas2.png",
    modelColor: const Color(0xff000000),
  ),
  ShoeModel(
    name: "ADIDAS",
    model: "SUPERSTAR",
    price: 90.00,
    imgAddress: "assets/images/adidas3.png",
    modelColor: const Color(0xffFFFFFF),
  ),
  // Jordan Models
  ShoeModel(
    name: "JORDAN",
    model: "AIR JORDAN 1",
    price: 200.00,
    imgAddress: "assets/images/jordan1.png",
    modelColor: const Color(0xffB63A47),
  ),
  ShoeModel(
    name: "JORDAN",
    model: "JORDAN DELTA",
    price: 150.00,
    imgAddress: "assets/images/jordan2.png",
    modelColor: const Color(0xff42424E),
  ),
  // Puma Models
  ShoeModel(
    name: "PUMA",
    model: "RS-X",
    price: 120.00,
    imgAddress: "assets/images/puma1.png",
    modelColor: const Color(0xff212121),
  ),
  ShoeModel(
    name: "PUMA",
    model: "SUEDE CLASSIC",
    price: 85.00,
    imgAddress: "assets/images/puma2.png",
    modelColor: const Color(0xff8B4513),
  ),
  ShoeModel(
    name: "PUMA",
    model: "FUTURE RIDER",
    price: 100.00,
    imgAddress: "assets/images/puma3.png",
    modelColor: const Color(0xffEB5757),
  ),
  // Gucci Models
  ShoeModel(
    name: "GUCCI",
    model: "ACE SNEAKER",
    price: 580.00,
    imgAddress: "assets/images/gucci1.png",
    modelColor: const Color(0xffD4AF37),
  ),
  ShoeModel(
    name: "GUCCI",
    model: "RHYTON SNEAKER",
    price: 690.00,
    imgAddress: "assets/images/gucci2.png",
    modelColor: const Color(0xffB0C4DE),
  ),
];


List<ShoeModel> itemsOnBag = [];

final List<UserStatus> userStatus = [
  UserStatus(
    emoji: '😴',
    txt: "Away",
    selectColor: const Color(0xff121212),
    unSelectColor: const Color(0xffbfbfbf),
  ),
  UserStatus(
    emoji: '💻',
    txt: "At Work",
    selectColor: const Color(0xff05a35c),
    unSelectColor: const Color(0xffCEEBD9),
  ),
  UserStatus(
    emoji: '🎮',
    txt: "Gaming",
    selectColor: const Color(0xffFFD237),
    unSelectColor: const Color(0xffFDDFBB),
  ),
  UserStatus(
    emoji: '🤫',
    txt: "Busy",
    selectColor: const Color(0xffba3a3a),
    unSelectColor: const Color(0xffdb9797),
  ),
];

final List categories = [
  'Nike',
  'Adidas',
  'Jordan',
  'Puma',
  'Gucci',

];
final List featured = [
  'New',
  'Featured',
  'Upcoming',
];

final List<double> sizes = [6, 7.5, 8, 9.5];
