import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/cubit/base_cubit.dart';
import 'package:my_app/models/comment.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> with BaseCubit {
  NoteCubit() : super(NoteLoading());

  Future<void> fetchNotes(String imdbId) async {
    emit(NoteLoading());
    final notes = await cloudFirestoreRepository.getNotes(imdbId);
    emit(NoteLoaded(notes));
  }

  Future<void> addNote(Note comment, String imdbId) async {
    await cloudFirestoreRepository.addNote(comment, imdbId);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'Notunuz eklendi');
    await fetchNotes(imdbId);
  }

  Future<void> removeNote(Note comment, String imdbId) async {
    await cloudFirestoreRepository.removeNote(comment, imdbId);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'Notunuz silindi');
    await fetchNotes(imdbId);
  }
}
