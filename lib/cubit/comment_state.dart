part of 'comment_cubit.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {
  const CommentLoading();
}

class CommentLoaded extends CommentState {
  final List<Note> comments;
  const CommentLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}
