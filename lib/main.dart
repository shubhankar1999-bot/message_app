
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/sms.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myController = new TextEditingController();
  String dropdownValue = 'SIM 1';
  bool _validate = false;
  late String status;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  Future<void> main2(String address, int index) async {
    try {
      SimCardsProvider provider = new SimCardsProvider();
      SimCard card = (await provider.getSimCards())[index];
      SmsSender sender = new SmsSender();
      SmsMessage message = new SmsMessage(address, "Hello");
      status = "Message Sent";
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          print("SMS is sent!");
        } else if (state == SmsMessageState.Delivered) {
          print("SMS is delivered!");
        }
      });
      sender.sendSms(message, simCard: card);
    }
    catch(e){
      status = "Message not Sent";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS App"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['SIM 1','SIM 2',]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          ),
            Divider(),
            TextField(
              obscureText: true,
              style: TextStyle(
                color: Colors.black
              ),
              decoration: InputDecoration(
                errorText: _validate?'Value Can\'t Be Empty' : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              controller: myController,
            ),
            Divider(),
            Text("Hello"),
            Divider(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  myController.text.isEmpty ? _validate = true : _validate = false;
                  if(!_validate && dropdownValue=="SIM 1"){
                    main2((myController.text).trim(),0);
                    Fluttertoast.showToast(
                        msg: status,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.yellow
                    );
                  }
                  else if(!_validate && dropdownValue=="SIM 2"){
                    main2((myController.text).trim(),1);
                    Fluttertoast.showToast(
                        msg: status,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.yellow
                    );
                  }
                });
              },
              child: Text('Send',
              style: TextStyle(color: Colors.white,
              backgroundColor: Colors.blueAccent),
            )
            )
          ],
        ),
      ),
    );
  }
}

