import 'package:RapidRecruits/screens/events_schedule_module.dart/events_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import '../../utilities/calender_client.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

import '../../utilities/constants.dart';

class SignInGoogle extends StatefulWidget {
  const SignInGoogle({Key? key}) : super(key: key);

  @override
  State createState() => SignInGoogleState();
}

const _scopes = [cal.CalendarApi.calendarScope];
final _googleSignIn = GoogleSignIn(scopes: _scopes);

class SignInGoogleState extends State<SignInGoogle> {
  GoogleSignInAccount? _currentUser;

  AuthClient? httpClient;
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        httpClient = (await _googleSignIn.authenticatedClient())!;
        CalendarClient.calendar = cal.CalendarApi(httpClient!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return const EventsDashboardScreen();
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text('Google Sign In'),
          backgroundColor: kPrimaryColorInstitute,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.error_outline,color: kPrimaryColorInstitute,size: 55,),
              const SizedBox(height: 10,),
              const Text('You are not currently signed in.'),
              const SizedBox(height: 30,),
              MaterialButton(
                height: 50,
                onPressed: () async{
                  await _handleSignIn();
                  },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: kPrimaryColorInstitute,
                child: const Text('Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
