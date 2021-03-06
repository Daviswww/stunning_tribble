import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stunning_tribble/infrastructure/auth/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;

  SignInBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SignInStateInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignInWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<SignInState> _mapLoginWithGooglePressedToState() async* {
    final user = await _authRepository.signInWithGoogle();
    yield* user.fold(
      (failure) async* {
        log("$failure");
        yield SignInStateFailure();
      },
      (success) async* {
        yield SignInStateSuccess();
      },
    );
  }
}
