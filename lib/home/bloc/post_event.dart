part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class CreatePost extends PostEvent {
  final String postText;
  final String userId;
  CreatePost(this.postText, this.userId);
}

class GetPost extends PostEvent {}
