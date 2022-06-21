import 'package:bridgeup/dashboard.dart';
import 'package:flutter/material.dart';

class Websites extends StatelessWidget {
  const Websites({Key? key}) : super(key: key);

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
        title: const Text('Institutions\' Websites'),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:   [

          const Center(

            child: Text ('Hi this is websites page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
          ),

          SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(onPressed: () {gotoHomeActivity(context);}, child: const Text('Return home'),
                // style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0.2) ),
              )),

        ],
      ),
    );
  }

}