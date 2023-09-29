import 'package:despesas_pessoais/components/adaptative_button.dart';
import 'package:despesas_pessoais/components/adaptative_date_picker.dart';
import 'package:despesas_pessoais/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextfield(
                controller: _titleController,
                onSubmit: (_) => _submitForm(),
                placeholder: 'Título',
              ),
              AdaptativeTextfield(
                controller: _valueController,
                onSubmit: (_) => _submitForm(),
                placeholder: 'Valor \$',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newValue) {
                  setState(() {
                    _selectedDate = newValue;
                  });
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AdaptativeButton(
                    label: 'Nova transação', onPressed: _submitForm),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text);

    if (title.isNotEmpty && value != null) {
      widget.onSubmit(title, value, _selectedDate);
    }
  }
}
