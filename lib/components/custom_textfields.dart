import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {

  final String labelText;
  final Function onSaved;
  final TextInputType? keyboardType;

  const PrimaryTextField({
    required this.labelText,
    required this.onSaved,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onSaved: (value) => onSaved(value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the ${labelText.toLowerCase()}';
        } else if(keyboardType == TextInputType.emailAddress) {
          if(!EmailValidator.validate(value)) {
            return 'Please enter a valid email address';
          }
        } else if(keyboardType == TextInputType.number) {
          if(value.length != 11) {
            return 'An 11 digit number is required';
          }
        }
        return null;
      },
    );
  }
}

class MultiLineTextField extends StatelessWidget {
  final Function onSaved;

  MultiLineTextField({required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Business description',
      ),
      onSaved: (value) => onSaved(value),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Enter your business description';
        }
      },
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final Function onSaved;

  PasswordTextField({required this.onSaved});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _hidePassword,
      enableSuggestions: false,
      autocorrect: false,
      onSaved: (value) => widget.onSaved(value),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _hidePassword = !_hidePassword),
        ),
        border: const OutlineInputBorder(),
        labelText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if(value.length < 8) {
          return 'Password should be at least 8 characters';
        }
        return null;
      },
    );
  }
}

class TimePickerTextField extends StatefulWidget {

  final String text;
  final Function onTimePicked;

  TimePickerTextField({required this.text, required this.onTimePicked});

  @override
  _TimePickerTextFieldState createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {

  final _myController = TextEditingController();
  int _hour = 0;
  int _minute = 0;

  void pickTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay(hour: _hour, minute: _minute);
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: widget.text.toUpperCase(),
    );

    // when the picker is dismissed but the user has initially picked a time
    if(_myController.text.isNotEmpty && pickedTime == null) {
      return;
    }

    _hour = pickedTime?.hour ?? 0;
    _minute = pickedTime?.minute ?? 0;
    final timeString = pickedTime?.format(context) ?? '12:00 AM';

    _myController.text = timeString;
    widget.onTimePicked(timeString);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _myController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.text,
        suffixIcon: Icon(Icons.access_time),
      ),
      onTap: () => pickTime(context),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Select your ${widget.text.toLowerCase()}';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _myController.dispose();
  }
}
