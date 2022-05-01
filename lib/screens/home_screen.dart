import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:plaid_flutter_app/constants/constants.dart';
import 'package:plaid_flutter_app/auth/api_keys.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late LinkTokenConfiguration _linkTokenConfiguration;
  bool _isBankLinked = false;
  String _linkedBankName = '';

  @override
  void initState() {
    super.initState();

    _linkTokenConfiguration = LinkTokenConfiguration(
      token: linkTokenApiKey,
    );

    PlaidLink.onSuccess(_onSuccessCallback);
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    print("onSuccess: ${metadata.description()}");

    setState(() {
      _isBankLinked = true;
      _linkedBankName = metadata.institution.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: Center(
          child: ElevatedButton(
            onPressed: () =>
                PlaidLink.open(configuration: _linkTokenConfiguration),
            child: Text(
              !_isBankLinked ? plaidLinkButtonText : plaidSuccessButtonText + _linkedBankName,
              style: buttonTextStyle,
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
