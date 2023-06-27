import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../tab/tab_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return SignInScreen(
  //     actions: [
  //       AuthStateChangeAction<SignedIn>((context, state) {
  //         if (!state.user!.emailVerified) {
  //           Navigator.pushNamed(context, '/verify-email');
  //         } else {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const TabPage(),
  //             ),
  //           );
  //         }
  //       }),
  //     ],
  //   );
  // }
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            headerBuilder: (context, constraints, _) {
              return const Center(
                child: Text(
                  'Instagram Clone',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              );
            },
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                if (!state.user!.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                }
              }),
            ],
          );
        }
        return const TabPage();
      },
    );
  }
}
