import 'package:bridgeup/applications.dart';
import 'package:bridgeup/login.dart';
import 'package:bridgeup/personInfo.dart';
import 'package:bridgeup/websites.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  gotoPersonActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PersonlInfo()),
    );
  }
  gotoWebsitesActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Websites()),
    );
  }

  gotoApplicationActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Applications()),
    );


  }



  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() async {
      showModalBottomSheet(context: context, builder: (context) {
        return Center(
          child: Container(

            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),


            child: SizedBox(
              height: 50,
              width: 1000,
              child: ElevatedButton(onPressed: () async {

                await FirebaseAuth.instance.currentUser?.delete().whenComplete(() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                ));
              }, style: ElevatedButton.styleFrom(primary: Colors.red[900]), child: const Text("Delete Account!"),),
            )),
        );
      });
    }



    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton.icon(

            icon: const Icon(Icons.person),
            label: const Text('logout'),

            onPressed: () async {
              await FirebaseAuth.instance.signOut().whenComplete(() => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                )
              });
            },
            style: TextButton.styleFrom(
                primary: Colors.black54,
                ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.settings),
            label: const Text('settings'),
            onPressed: () => _showSettingsPanel(),
            style: TextButton.styleFrom(
              primary: Colors.black54,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:   [
          const Center(

            child: Text ('BridgeUp',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
          ),

          SizedBox(
              height: 50,
              width: 1000,
              child: ElevatedButton(onPressed: () {gotoPersonActivity(context);}, child: const Text('UPLOAD/UPDATE PERSONAL INFORMATION'),
                // style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0.2) ),
              )),
          SizedBox(
              height: 50,
              width: 1000,
              child: ElevatedButton(onPressed: () {}, child: const Text('CHECK PROSPECTUS'),
                // style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0.2) ),
              )),
          SizedBox(
              height: 50,
              width: 1000,
              child: ElevatedButton(onPressed: () {gotoApplicationActivity(context);}, child: const Text('APPLY FOR ME'),
                // style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0.2) ),
              )),
          SizedBox(
              height: 50,
              width: 1000,
              child: ElevatedButton(onPressed: () {gotoWebsitesActivity(context);}, child: const Text('APPLY FOR YOURSELF'),
                // style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0.2) ),
              )),
          SizedBox(
              height: 50,
              width: 1000,
              child: ElevatedButton(onPressed: () {}, child: const Text('RAISE MONEY FOR APPLICATIONS'),
                // style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0.2) ),
              )),




        ],
      ),
    );
  }

}