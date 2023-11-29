import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const routeName = '/verify';
  final String email;

  VerifyEmailScreen({required this.email});

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _codeController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyEmail() {
    setState(() {
      _isLoading = true;
    });

    // TODO: Add your email verification logic here

    setState(() {
      _isLoading = false;
    });

    // Navigate to the next screen after email verification is complete
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Verification code sent to ${widget.email}',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyEmail,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Verify Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
