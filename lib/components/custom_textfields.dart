import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final Function onChanged;
  final TextInputType? keyboardType;

  const PrimaryTextField(
      {required this.labelText, required this.onChanged, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
      onChanged: (value) => onChanged(value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the ${labelText.toLowerCase()}';
        }
        return null;
      },
    );
  }
}

class MultiLineTextField extends StatelessWidget {
  final Function onChanged;
  final String labelText;

  const MultiLineTextField({
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'labelText',
      ),
      onChanged: (value) => onChanged(value),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final Function onChanged;

  PasswordTextField({required this.onChanged});

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
      onChanged: (value) => widget.onChanged(value),
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
    if (_myController.text.isNotEmpty && pickedTime == null) {
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    _myController.dispose();
  }
}
