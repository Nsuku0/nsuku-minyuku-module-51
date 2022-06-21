import 'package:bridgeup/dashboard.dart';
import 'package:flutter/material.dart';

class PersonlInfo extends StatelessWidget {
  const PersonlInfo({Key? key}) : super(key: key);

  gotoHomeActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:   [

          Container(
            //color: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const TextField(

              decoration: InputDecoration(
                hintText: 'Update first name',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
          Container(
            //color: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const TextField(

              decoration: InputDecoration(
                hintText: 'Update last name',
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),

          SizedBox(
              height: 50,
              width: 100,
              child: ElevatedButton(onPressed: () {}, child: const Text('Save'),
                // style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0.2) ),
              )),

        ],
      ),
    );
  }

}