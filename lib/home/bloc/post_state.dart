part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final List<Map<String, dynamic>> posts;
  PostSuccess(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}
