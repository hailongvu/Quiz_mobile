import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_learn/lesson/bloc/states/lesson_state.dart';
import 'package:let_learn/lesson/repository/models/model/data_lesson.dart';
import 'dart:developer';

import '../../base/repository/base_api_response.dart';
import '../repository/lesson_repository.dart';
import 'event/lesson_event.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc({
    required LessonRepository lessonRepository,
  })  : _lessonRepository = lessonRepository,
        super(const LessonState.unknown()) {
    on<LoadDataLessonDetails>(_onLoadDataLessonDetails);
    on<UpdateDataLesson>(_onUpdateDataLesson);
    on<CreateDataLesson>(_onCreateDataLesson);
    on<RemoveLesson>(_onRemoveLesson);
    on<AddLessonDetail>(_onAddLessonDetail);
    on<RemoveLessonDetail>(_onRemoveLessonDetail);
  }

  final LessonRepository _lessonRepository;

  void _onLoadDataLessonDetails(
      LoadDataLessonDetails event, Emitter<LessonState> state) async {
    int idLesson = event.idLesson;
    await _lessonRepository.getLessonDetails(idLesson).then((value) {
      if (value.responseState == ResponseStatus.error) {
        emit(LessonState.error(value.errorMessage));
      } else {
        emit(LessonState.loaded(LessonStatus.success, value.data));
      }
    });
  }

  void _onUpdateDataLesson(
      UpdateDataLesson event, Emitter<LessonState> state) async {
    await _lessonRepository
        .updateLesson(event.idLesson, event.nameLesson, event.descriptionLesson,
            event.statusLesson, event.lessonDetailsList)
        .then((value) {
      if (value.responseState == ResponseStatus.error) {
        emit(LessonState.error(value.errorMessage));
      } else {
        emit(const LessonState.updated(LessonStatus.updated));
      }
    });
  }

  void _onCreateDataLesson(
      CreateDataLesson event, Emitter<LessonState> state) async {
    await _lessonRepository
        .createNewLesson(event.lesson, event.lessonDetails)
        .then((value) {
      if (value.responseState == ResponseStatus.error) {
        emit(LessonState.error(value.errorMessage));
      } else {
        emit(const LessonState.created(LessonStatus.created));
      }
    });
  }

  void _onRemoveLesson(RemoveLesson event, Emitter<LessonState> emit) async {
    await _lessonRepository.removeLesson(event.idLessonDetail).then((value) {
      log('remove lesson, list size ${value.responseState}');
      if (value.responseState == ResponseStatus.error) {
        emit(LessonState.error(value.errorMessage));
      } else {
        emit(const LessonState.removedLesson(LessonStatus.success));
      }
    });
  }

  void _onAddLessonDetail(AddLessonDetail event, Emitter<LessonState> emit) {
    _lessonRepository
        .addLessonDetails(
            event.id, event.term, event.definition, event.lessonDetailsList)
        .then((value) {
      log('add lesson detail, list size ${event.lessonDetailsList.length}');
      emit(LessonState.addLessonDetail(value));
    });
  }

  void _onRemoveLessonDetail(
      RemoveLessonDetail event, Emitter<LessonState> emit) {
    _lessonRepository
        .removeLessonDetails(event.idLessonDetail, event.lessonDetailsList)
        .then((value) {
      log('remove lesson detail, list size ${event.lessonDetailsList.length}');
      emit(LessonState.removeLessonDetail(value));
    });
  }
}
