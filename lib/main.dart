import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
        // useMaterial3: true,
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

  var wtController= TextEditingController();
  var ftController=TextEditingController();
  var inController=TextEditingController();
  var result="";
  var bgcolor =Colors.indigo.shade50;


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
                  'BMI',style: TextStyle(fontSize: 40,fontWeight: FontWeight.w900,color: Colors.blue.shade700,

                ),),
                SizedBox(height: 21,),


                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.line_weight),
                    label: Text('Enter Your Weight (in Kgs)'),

                  ),
                  keyboardType: TextInputType.number,

                ),
                SizedBox(height: 11,),


                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.height),
                    label: Text('Enter your Height (in Feet) ')
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 11,),


                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.height),
                    label: Text('Enter your Height (in inchs)')

                  ),
                  keyboardType: TextInputType.number,

                ),
                SizedBox(height: 21,),


                ElevatedButton(onPressed: (){
                  var wt =wtController.text.toString();
                  var ft =ftController.text.toString();
                  var inc=inController.text.toString();

                  if(wt!=""&& ft!=""&& inc!=""){
                    int iwt =int.parse(wt);
                    int ift=int.parse(ft);
                    int iinc=int.parse(inc);

                    var tinc=(ift*12)+iinc;
                    var tcm=tinc*2.54;
                    var tm=tcm/100;
                    var bmi=iwt/(tm*tm);
                    var msg="";

                    if (bmi>25){
                      msg="You are OverWeight !!";
                      bgcolor=Colors.red.shade100;


                    }else if(bmi<13){
                      msg="You are underWeight !!";
                      bgcolor=Colors.red.shade100;


                    }else{
                      msg="You are Healthy !!";
                      bgcolor=Colors.green.shade100;


                    }
                    setState(() {
                      result=" \n $msg \n Your BMI is ${bmi.toStringAsFixed(2)}";
                    });


                  }else
                    {
                      setState(() {
                        result="Please Enter all the Required Blanks!!";
                      });
                    }
                },


                    child: const Text('Calculate')),
                Text(result, style:TextStyle(fontSize: 21),)
              ],
            ),
          ),
        ),
      ),

    );
  }
}
