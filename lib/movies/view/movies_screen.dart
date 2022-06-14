// ignore_for_file: library_private_types_in_public_api

import 'package:filmfan/movies/cubit/movies_cubit.dart';
import 'package:filmfan/movies/cubit/movies_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final screenCubit = MoviesCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MoviesCubit, MoviesState>(
        bloc: screenCubit,
        listener: (BuildContext context, MoviesState state) {
          if (state.error != null) {}
        },
        builder: (BuildContext context, MoviesState state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(MoviesState state) {
    return ListView(
      children: const [
        Center(
          child: Text('Welcome'),
        )
      ],
    );
  }
}
