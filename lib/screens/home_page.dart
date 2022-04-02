import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'entrance_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
//--------------------------------------------------------------------------------------------------//
//                                             SIGN OUT                                             //
//--------------------------------------------------------------------------------------------------//

                onPressed: () {
                  MyAuthService().signOut().then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const EntrancePage()),
                      ),
                    );
                  });
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                  size: 30,
                ),
              )),
        ],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: const Center(
        child: Text('HOMEPAGE'),
      ),
    );
  }
}
