part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteLoading extends NoteState {
  const NoteLoading();
}

class NoteLoaded extends NoteState {
  final List<Note> notes;
  const NoteLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}
