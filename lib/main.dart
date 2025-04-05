import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Sign-In',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GoogleSignInScreen(),
    );
  }
}

class GoogleSignInScreen extends StatefulWidget {
  @override
  _GoogleSignInScreenState createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;

  @override
  void initState() {
    super.initState();
   
  }

  Future<void> _handleSignIn() async {
    try {
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
      
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

     
    } catch (e) {
      print('Error during sign-in: $e');
    }
  }

  Future<void> _handleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    setState(() {
      _user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: 
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _handleSignIn,
                    child: Text('Sign in with Google'),
                  ),
                ],
              )
           
      ),
    );
  }
}
