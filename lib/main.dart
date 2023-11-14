import 'package:flutter/material.dart';

void main() {
  runApp(BBM_MOBILE_AZIZA());
}

class BBM_MOBILE_AZIZA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BBMCalculatorScreen(),
    );
  }
}

class BBMCalculatorScreen extends StatefulWidget {
  @override
  BBMCalculatorScreenState createState() => BBMCalculatorScreenState();
}

class BBMCalculatorScreenState extends State<BBMCalculatorScreen> {
  String cityDestination = '';
  double distance = 0.0;
  String selectedFuelType = 'Pertalite';
  String selectedVehicle = 'Avanza';
  double fuelPrice = 0.0;
  double consumptionRatio = 0.0;
  double totalCost = 0.0;

  Map<String, double> fuelPrices = {
    'Pertalite': 9000.0,
    'Pertamax': 10000.0,
    'Solar': 8500.0,
  };

  Map<String, double> consumptionRatios = {
    'Avanza': 15.0,
    'Xenia': 14.0,
    'Sigra': 16.0,
    'Brio': 18.0,
  };

  void calculateTotalCost() {
    setState(() {
      fuelPrice = fuelPrices[selectedFuelType]!;
      consumptionRatio = consumptionRatios[selectedVehicle]!;
      totalCost = (distance / consumptionRatio) * fuelPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kakulator BBM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Kota Tujuan'),
              onChanged: (value) {
                setState(() {
                  cityDestination = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Jarak (Km)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  distance = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: selectedFuelType,
              items: fuelPrices.keys.map((String fuel) {
                return DropdownMenuItem<String>(
                  value: fuel,
                  child: Text(fuel),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFuelType = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Pilihan BBM'),
            ),
            DropdownButtonFormField<String>(
              value: selectedVehicle,
              items: consumptionRatios.keys.map((String vehicle) {
                return DropdownMenuItem<String>(
                  value: vehicle,
                  child: Text(vehicle),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedVehicle = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Pilihan Kendaraan'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calculateTotalCost,
              child: const Text('Hitung BBM'),
            ),
            const SizedBox(height: 20.0),
            Text('Total Biaya BBM: $totalCost'),
          ],
        ),
      ),
    );
  }
}
