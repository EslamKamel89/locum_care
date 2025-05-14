import 'package:flutter/material.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/validator.dart';
import 'package:locum_care/core/widgets/auth_text_form_field.dart';

class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({
    super.key,
    required TextEditingController passwordController,
    required TextEditingController passwordConfirmController,
  }) : _passwordController = passwordController,
       _passwordConfirmController = passwordConfirmController;

  final TextEditingController _passwordController;
  final TextEditingController _passwordConfirmController;

  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  bool showUpdatePassword = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  showUpdatePassword = true;
                });
              },
              child: Text(
                showUpdatePassword ? 'Pick Safe Password' : 'Create a New Password ? ',
                style: TextStyle(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            showUpdatePassword
                ? InkWell(
                  onTap: () {
                    setState(() {
                      showUpdatePassword = false;
                      widget._passwordController.text = '';
                      widget._passwordConfirmController.text = '';
                    });
                  },
                  child: const Icon(Icons.close),
                )
                : const SizedBox(),
          ],
        ),
        showUpdatePassword
            ? Column(
              children: [
                const SizedBox(height: 10),
                AuthTextFormField(
                  obscureText: true,
                  labelText: "Password",
                  prefixIcon: Icons.lock_outline,
                  controller: widget._passwordController,
                  validator: (input) {
                    if (input == null || input.isEmpty) return null;
                    return valdiator(
                      input: input,
                      label: 'Password',
                      isRequired: true,
                      minChars: 5,
                      maxChars: 50,
                    );
                  },
                ),
                const SizedBox(height: 15),
                AuthTextFormField(
                  obscureText: true,
                  labelText: "Confirm Password",
                  prefixIcon: Icons.lock_outline,
                  controller: widget._passwordConfirmController,
                  validator: (input) {
                    if (widget._passwordController.text.isEmpty) return null;
                    return valdiator(
                      input: input,
                      label: 'Confirm Password',
                      isRequired: true,
                      minChars: 5,
                      maxChars: 50,
                      isConfirmPassword: true,
                      firstPassword: widget._passwordController.text,
                    );
                  },
                ),
              ],
            )
            : const SizedBox(),
      ],
    );
  }
}
