// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(SmokingHabitApp());
}

class SmokingHabitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int yearsSmoking;
  late int cigarettesPerDay;
  late double cigarettePrice;
  String? cigaretteBrand;
  double lungHealth = 100.0;
  int yearsReduced = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://img.freepik.com/premium-photo/vertical-portrait-ill-senior-man-lying-hospital-bed-with-oxygen-supplementation-mask-eyes-closed-copy-space_236854-30557.jpg?w=2000"),fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.all(66.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  yearsSmoking = value.isEmpty ? 0 : int.parse(value);
                },
                decoration: InputDecoration(
                  labelText: 'Kaç Yıldır Sigara İçiyorsunuz?',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cigarettesPerDay = int.parse(value);
                },
                decoration: InputDecoration(
                  labelText: 'Günde Kaç Sigara İçiyorsunuz?',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cigarettePrice = double.parse(value);
                },
                decoration: InputDecoration(
                  labelText: '1 Adet Sigara Fiyatı (TL)',
                ),
              ),
              DropdownButtonFormField<String>(
                value: cigaretteBrand,
                    onChanged: (newValue) {
                  setState(() {
                    cigaretteBrand = newValue;
                    lungHealth -= 15.0;
                    yearsReduced += 12;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'Lark',
                    child: Text('Lark'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Marlboro',
                    child: Text('Marlboro'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Parlament',
                    child: Text('Parlament'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Camel',
                    child: Text('Camel'),
                  ),
                ],
               
                decoration: InputDecoration(labelText: "Sigara Markanız"),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black87),
                onPressed: () {
                  if (yearsSmoking != null &&
                      cigarettesPerDay != null &&
                      cigarettePrice != null &&
                      cigaretteBrand != null) {
                    final totalCigarettes = yearsSmoking * cigarettesPerDay * 365;
                    final totalCost = totalCigarettes * cigarettePrice;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          totalCigarettes: totalCigarettes,
                          totalCost: totalCost, yearsReduced: yearsReduced, lungHealth:lungHealth,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Sonuçları Gör'),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int totalCigarettes;
  final double totalCost;
  final double lungHealth;
  final int yearsReduced;

   ResultScreen({required this.totalCigarettes, required this.totalCost, required this.lungHealth, required this.yearsReduced});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sonuç'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Toplam İçilen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox
   (
height: 16,
),
Text(
'$totalCigarettes Sigara içildi',
style: TextStyle(fontSize: 18),
),
SizedBox(
height: 16,
),
Text(
'Sigaraya giden maliyet',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(
height: 16,
),
Text(
'$totalCost TL',
style: TextStyle(fontSize: 18),
),
 SizedBox(height: 16),
              CircularProgressIndicator(
                color: Colors.green,
                value: lungHealth / 100,
                strokeWidth: 10,
              ),
              SizedBox(height: 16,),
              Text('Akciğer Sağlığı: ${(100-lungHealth).toStringAsFixed(1)}% Azaldı '),
              SizedBox(height: 16),
              CircularProgressIndicator(
                color: Colors.red,
                value: yearsReduced / 12, // Her 100 sigara için 1 ay azaldığı varsayılarak hesaplandı
                strokeWidth: 10,
              ),
               SizedBox(height: 16,),
              Text('Ömrünüzden Azalan Yıl: ${yearsReduced ~/ 12} yıl ${yearsReduced % 12} ay'),
],
),
),
      ),
);
}
}