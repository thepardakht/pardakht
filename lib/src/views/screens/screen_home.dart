import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pardakht/src/blocs/auth_bloc.dart';
import 'package:pardakht/src/blocs/states/transactions_state.dart';
import 'package:pardakht/src/blocs/states/wallet_state.dart';
import 'package:pardakht/src/blocs/transactions_bloc.dart';

import 'package:pardakht/src/blocs/wallet_bloc.dart';
import 'package:pardakht/src/views/components/credit_card.dart';
import 'package:pardakht/src/views/components/expansion_items.dart';
import 'package:pardakht/src/views/screens/screen_create_transaction.dart';

class ScreenHome extends StatelessWidget {
  static const String path = "/";
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currenUserData = context.read<AuthBloc>().state.user;
    var creditCard = BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return CreditCard(
          holderName: currenUserData.name ?? "",
          amount: state.wallet.amount ?? 0.00,
          issuer: "Pardakht",
        );
      },
    );
    var paymentHistories = BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        final transactions = state.transactions;
        final items = transactions.map((transaction) {
          return ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    transaction.destinationAccountProfileUrl ?? ""),
              ),
              title: Text(transaction.destinationAccountName ?? ""),
              subtitle: Text("@${transaction.destinationAccountUsername}"),
              children: [
                ExpansionItems(items: [
                  ExpansionItem(
                      title: "Message", subtitle: transaction.description),
                  ExpansionItem(
                      title: "Type",
                      subtitle: transaction.transactionType?.name),
                  ExpansionItem(
                      title: "Amount", subtitle: "${transaction.amount} \$"),
                  ExpansionItem(
                      title: "Date",
                      subtitle: DateFormat('EEEE, MMMM d, y H:mm a')
                          .format(transaction.transactionDate!)),
                  ExpansionItem(
                      title: "Status",
                      subtitle: transaction.transactionStatus?.name),
                  ExpansionItem(title: "From", subtitle: transaction.userId),
                  ExpansionItem(
                      title: "To", subtitle: transaction.destinationAccountId),
                ])
              ]);
        });

        return SliverList(delegate: SliverChildListDelegate(items.toList()));
      },
    );
    final amount = BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (previous, current) {
        return previous.wallet.amount != current.wallet.amount;
      },
      builder: (context, state) {
        return Text(
          "\$ ${state.wallet.amount}",
          style: theme.textTheme.titleLarge
              ?.copyWith(color: theme.colorScheme.primary),
        );
      },
    );
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        onTap: (value) {
          if (value == 1) context.push("/search");
          if (value == 2) context.push("/wallet");
        },
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.rectangle_3_offgrid_fill),
              icon: Icon(CupertinoIcons.rectangle_3_offgrid),
              label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: "Wallet",
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.outline.withAlpha(30),
                  ),
                  color: theme.colorScheme.primary,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                  ),
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(currenUserData.profilePictureUrl ?? ""),
              ),
              title: Text(currenUserData.name ?? ""),
              subtitle: Text("@${currenUserData.username}"),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Amount"),
                  amount,
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider(
              items: [creditCard],
              options: CarouselOptions(
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () => context.push(ScreenCreateTransaction.path),
                    child: const Text("Send"),
                  )),
                  const SizedBox(width: 8),
                  Expanded(
                      child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text("Deposit"),
                    icon: const Icon(Icons.add),
                  ))
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: PaymentHistoryTitle(),
          ),
          paymentHistories
        ],
      ),
    );
  }
}

class PaymentHistoryTitle extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        'Payment History',
        style: theme.textTheme.displaySmall?.copyWith(fontSize: 18),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
