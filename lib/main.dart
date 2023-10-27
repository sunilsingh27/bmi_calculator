import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum WeightUnit { kg, lb }
enum HeightUnit { cm, ftIn }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weightController = TextEditingController();
  var feetController = TextEditingController();
  var inchesController = TextEditingController();
  var cmController = TextEditingController();
  var result = "";
  var bgcolor = Colors.indigo.shade50;
  var selectedWeightUnit = WeightUnit.kg;
  var selectedHeightUnit = HeightUnit.cm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Container(
        color: bgcolor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BMI',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue.shade700,
                  ),
                ),
                SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<WeightUnit>(
                      value: selectedWeightUnit,
                      onChanged: (value) {
                        setState(() {
                          selectedWeightUnit = value!;
                        });
                      },
                      items: WeightUnit.values
                          .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit == WeightUnit.kg ? 'Kg   ' : 'Lb'),
                      ))
                          .toList(),
                    ),
                    SizedBox(width: 21),
                    Expanded(
                      child: TextField(
                        controller: weightController,
                        decoration: InputDecoration(
                          prefix: Icon(Icons.line_weight),
                          label: Text('Enter Your Weight'),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<HeightUnit>(
                      value: selectedHeightUnit,
                      onChanged: (value) {
                        setState(() {
                          selectedHeightUnit = value!;
                        });
                      },
                      items: HeightUnit.values
                          .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit == HeightUnit.cm ?'cm': 'ft/in'),
                      ))
                          .toList(),
                    ),
                    SizedBox(width: 21),
                    Expanded(
                      child: selectedHeightUnit == HeightUnit.cm
                          ? TextField(
                        controller: cmController,
                        decoration: InputDecoration(
                          prefix: Icon(Icons.height),
                          label: Text('Enter your Height (in cm)'),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      )
                          : Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: feetController,
                              decoration: InputDecoration(
                                prefix: Icon(Icons.height),
                                label: Text('Feet'),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: inchesController,
                              decoration: InputDecoration(
                                prefix: Icon(Icons.height),
                                label: Text('Inches'),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 21),
                ElevatedButton(
                  onPressed: () {
                    var weight = weightController.text.toString();
                    var cm = cmController.text.toString();
                    var feet = feetController.text.toString();
                    var inches = inchesController.text.toString();

                    if (weight != "") {
                      double iweight = double.parse(weight);
                      double iheight;

                      if (selectedHeightUnit == HeightUnit.cm) {
                        iheight = double.parse(cm);
                      } else {
                        iheight = (double.parse(feet) * 30.48) + (double.parse(inches) * 2.54);
                      }

                      // Convert weight to kg if the selected unit is lb
                      if (selectedWeightUnit == WeightUnit.lb) {
                        iweight = iweight * 0.453592;
                      }

                      var bmi = iweight / ((iheight / 100) * (iheight / 100));
                      var msg = "";

                      if (bmi > 30) {
                        msg = "You are Obese!!";
                        bgcolor = Colors.red.shade100;
                      } else if (bmi > 25 && bmi <= 29.9) {
                        msg = "You are Overweight!!";
                        bgcolor = Colors.orange.shade100;
                      } else if (bmi < 18.5) {
                        msg = "You are underWeight !!";
                        bgcolor = Colors.red.shade100;
                      } else {
                        msg = "You are Healthy !!";
                        bgcolor = Colors.green.shade100;
                      }
                      setState(() {
                        result = "\n $msg \n Your BMI is ${bmi.toStringAsFixed(2)}";
                      });
                    } else {
                      setState(() {
                        result = "Please Enter all the Required Blanks!!";
                      });
                    }
                  },
                  child: const Text('Calculate'),
                ),
                Text(result, style: TextStyle(fontSize: 21)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
