import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();;
        }
      },
      child: MaterialApp(
        title: 'Numerical Integrator',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData.dark(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController values = TextEditingController();
  TextEditingController delta = TextEditingController();

  String res = '0';

  void calculate() {
    if (values.text.length != 0 && delta.text.length != 0) {
      // print('hello');
      List<String> a = values.text.split(',');
      // print(a);
      double b = double.parse(delta.text);
      List<double> intValues = a.map(double.parse).toList();
      // print(a);
      // print(intValues.runtimeType);
      // print(intValues[0] + intValues[1]);
      int noOfValues = intValues.length;

      if (noOfValues % 2 == 0) {
        setState(() {
          res = trapezoidal(intValues, b).toStringAsFixed(3);
        });
      } else {
        setState(() {
          res = simpson(intValues, b).toStringAsFixed(3);
        });
      }
    }
  }
    

  double trapezoidal(List<double> v, double d) {
    var sum = v[0] + v[v.length - 1];
    if (v.length > 2) {
      for (int i = 1; i < v.length - 1; i++) {
        sum += 2 * v[i];
      }
    }
    double result = d * sum / 2;
    return result;
  }

  double simpson(List<double> v, double d) {
    var sum = v[0] + v[v.length - 1];
    for (int i = 1; i < v.length - 1; i++) {
      if (i % 2 == 1) {
        sum += 4 * v[i];
      } else {
        sum += 2 * v[i];
      }
    }
    double result = d * sum / 3;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Numerical Integrator',
            style: TextStyle(color: Colors.deepPurpleAccent),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              "Output: $res",
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 80),
              child: TextField(
                // maxLengthEnforced: false,
                controller: values,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Comma seperated values',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
                cursorColor: Colors.deepPurpleAccent,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 80),
              child: TextField(
                controller: delta,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Delta',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  // hintStyle: TextStyle(color: Colors.deepPurpleAccent.withOpacity(0.5))
                ),
                cursorColor: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              child: Text('Calculate'),
              color: Colors.deepPurpleAccent,
              onPressed: calculate,
            )
          ],
        ));
  }
}
