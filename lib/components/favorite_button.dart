import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugi_oh_cards/models/user_model.dart';

import '../bloc/favorites/bloc/favorites_bloc.dart';
import '../bloc/log_in/bloc/log_in_bloc.dart';

class FavoriteChange extends StatefulWidget {
  MyUser myUser;
  final int id;
  FavoriteChange({
    Key? key,
    required this.myUser,
    required this.id,
  }) : super(key: key);

  @override
  State<FavoriteChange> createState() => _FavoriteChangeState();
}

class _FavoriteChangeState extends State<FavoriteChange> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue, backgroundColor: Colors.white),
        onPressed: () {
          setState(() {
            if (widget.myUser.favorites.contains(widget.id)) {
              // doi state va cap nhat lai cho cac bloc
              widget.myUser.favorites.remove(widget.id);
              context.read<LogInBloc>().add(LogInChangeInfo(
                  field: "favorites", data: widget.myUser.favorites));
              context
                  .read<FavoritesBloc>()
                  .add(FavoritesLoad(ids: widget.myUser.favorites));
            } else {
              widget.myUser.favorites.add(widget.id);
              context.read<LogInBloc>().add(LogInChangeInfo(
                  field: "favorites", data: widget.myUser.favorites));
              context
                  .read<FavoritesBloc>()
                  .add(FavoritesLoad(ids: widget.myUser.favorites));
            }
          });
        },
        child: !widget.myUser.favorites.contains(widget.id)
            ? const Icon(
                Icons.favorite_outline,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite,
                color: Colors.red,
              ));
  }
}
