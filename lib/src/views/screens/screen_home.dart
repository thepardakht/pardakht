import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pardakht/src/blocs/auth_bloc.dart';

import 'package:pardakht/src/blocs/user_bloc.dart';
import 'package:pardakht/src/views/components/credit_card.dart';

class ScreenHome extends StatelessWidget {
  static const String path = "/";
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currenUserData = context.read<AuthBloc>().state.user;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.rectangle_3_offgrid_fill),
              icon: Icon(CupertinoIcons.rectangle_3_offgrid),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search"),
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
              leading: const CircleAvatar(),
              title: Text(currenUserData.name ?? ""),
              subtitle: Text("@${currenUserData.username}"),
              trailing: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Amount"),
                  Text("\$ 200,000"),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider(
              items: const [
                CreditCard(
                  holderName: "Sayed Ali sina",
                  amount: 2000,
                  issuer: "Pardakht",
                )
              ],
              options: CarouselOptions(
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("index $index"),
              );
            },
          )
        ],
      ),
    );
  }
}
