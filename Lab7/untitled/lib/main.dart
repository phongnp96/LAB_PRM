import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SignupScreen(), debugShowCheckedModeBanner: false));

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final _passCtrl = TextEditingController();

  String _email = '';
  bool isCheckingEmail = false;

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confirmFocus = FocusNode();

  String? validateName(String? val) =>
      (val == null || val.isEmpty) ? 'Name is required' : null;

  String? validateEmail(String? val) {
    if (val == null || val.isEmpty) return 'Email is required';
    if (!val.contains('@') || !val.contains('.')) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? val) {
    if (val == null || val.isEmpty) return 'Password is required';
    if (val.length < 8) return 'Minimum 8 characters';
    if (!RegExp(r'[0-9]').hasMatch(val)) return 'At least 1 digit required';
    return null;
  }

  String? validateConfirm(String? val) {
    if (val == null || val.isEmpty) return 'Confirm password is required';
    if (val != _passCtrl.text) return 'Passwords do not match';
    return null;
  }

  Future<void> _submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    FocusScope.of(context).unfocus();

    setState(() => isCheckingEmail = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isCheckingEmail = false);

    if (!mounted) return;
    if (_email.toLowerCase().startsWith('taken')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This email is already taken')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Signup')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: [
                TextFormField(
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: validateName,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  focusNode: _emailFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passFocus),
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: validateEmail,
                  onSaved: (val) => _email = val ?? '',
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passCtrl,
                  focusNode: _passFocus,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmFocus),
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: validatePassword,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  focusNode: _confirmFocus,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  validator: validateConfirm,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isCheckingEmail ? null : _submit,
                  child: isCheckingEmail
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}