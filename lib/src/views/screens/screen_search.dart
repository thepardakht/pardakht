import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pardakht/src/blocs/states/users_state.dart';
import 'package:pardakht/src/blocs/users_bloc.dart';
import 'package:pardakht/src/views/screens/screen_create_transaction.dart';

class ScreenSearch extends StatefulWidget {
  static const String path = "/search";
  final String? value;
  const ScreenSearch({super.key, this.value});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      centerTitle: true,
      title: CupertinoSearchTextField(
        controller: _searchController,
        onSubmitted: context.read<UsersBloc>().searchUsers,
      ),
    );
    var sliverList = BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (p, c) => p.status.isSearched != c.status.isSearched,
      builder: (context, state) {
        final users = state.searchResult;
        final items = users.map(
          (user) => ListTile(
            onTap: () => context
                .push("${ScreenCreateTransaction.path}?sendTo=${user.id}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                user.profilePictureUrl ?? "",
              ),
            ),
            title: Text(user.name ?? ""),
          ),
        );
        return SliverList(
          delegate: SliverChildListDelegate(
            items.toList(),
          ),
        );
      },
    );

    const emtyList = SliverFillRemaining(
      child: Center(
        child: Text("No User :("),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [state.searchResult.isEmpty ? emtyList : sliverList],
          );
        },
      ),
    );
  }
}
