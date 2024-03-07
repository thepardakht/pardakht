import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pardakht/src/blocs/transaction_bloc.dart';
import 'package:pardakht/src/views/screens/screen_search.dart';

class FormCreateTransaction extends StatefulWidget {
  final String? initSendToValue;
  final GlobalKey<FormState>? formKey;
  const FormCreateTransaction({super.key, this.initSendToValue, this.formKey});

  @override
  State<FormCreateTransaction> createState() => _FormCreateTransactionState();
}

class _FormCreateTransactionState extends State<FormCreateTransaction> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        TextEditingController(text: widget.initSendToValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.withAlpha(30)),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Please fill in the requested information accurately to send money",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Username | Email | Phone",
              style: theme.textTheme.labelLarge,
            ),
            TextFormField(
              controller: _textEditingController,
              onTap: () => context.push(ScreenSearch.path),
              onSaved: context.read<TransactionBloc>().setDestinationId,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Enter something",
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Message",
              style: theme.textTheme.labelLarge,
            ),
            TextFormField(
              onSaved: context.read<TransactionBloc>().setMessage,
              maxLines: 4,
              maxLength: 200,
              decoration: const InputDecoration(
                  hintText: "Enter your message", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Text(
              "Amount",
              style: theme.textTheme.labelLarge,
            ),
            TextFormField(
              onSaved: context.read<TransactionBloc>().setAmount,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.attach_money_outlined),
                hintText: "0.00",
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
