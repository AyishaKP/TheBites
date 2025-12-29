import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebites/src/login/presentation/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthState(isLoading: true));
	
	Future<void> loadInitialData() async {
		final stableState = state;
		try {
		  emit(state.copyWith(isLoading: true));
	
		  // TODO your code here
	
		  emit(state.copyWith(isLoading: false));
		} catch (error) {
		  emit(state.copyWith(error: error.toString()));
		  emit(stableState.copyWith(isLoading: false));
		}
	}
}
