import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_app/home/service/home_service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  HomeService homeService = HomeService();

  PostBloc() : super(PostInitial()) {
    on<GetPost>((event, emit) async {
      emit(PostLoading());
      await emit.forEach(
        homeService.getPosts(),
        onData: (posts) => PostSuccess(posts),
        onError: (error, _) => PostError(error.toString()),
      );
    });
  }
}
