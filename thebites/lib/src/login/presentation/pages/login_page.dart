import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebites/src/login/presentation/auth/auth_cubit.dart';
import 'package:thebites/src/login/presentation/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
	const LoginPage({Key? key}) : super(key: key);
	
	@override
	_LoginPageState createState() => _LoginPageState();
}
	
class _LoginPageState extends State<LoginPage> {
	final screenCubit = AuthCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<AuthCubit, AuthState>(
				bloc: screenCubit,
				listener: (BuildContext context, AuthState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, AuthState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(AuthState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
