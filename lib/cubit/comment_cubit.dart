import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/cubit/base_cubit.dart';
import 'package:my_app/models/comment.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> with BaseCubit {
  CommentCubit() : super(CommentLoading());

  Future<void> fetchComments(String imdbId) async {
    emit(CommentLoading());
    final comments = await cloudFirestoreRepository.getComments(imdbId);
    emit(CommentLoaded(comments));
  }

  Future<void> addComment(Note comment, String imdbId) async {
    await cloudFirestoreRepository.addComment(comment, imdbId);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'Yorumunuz eklendi');
    await fetchComments(imdbId);
  }

  Future<void> removeComment(Note comment, String imdbId) async {
    await cloudFirestoreRepository.removeComment(comment, imdbId);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'Yorumunuz silindi');
    await fetchComments(imdbId);
  }
}
