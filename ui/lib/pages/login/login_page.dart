import 'package:authentication_repository/authentication_repository.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart' hide TextButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gamebase_ui/bloc/login/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: const Scaffold(
        body: SafeArea(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Authentication Failure'),
              ),
            );
        }
      },
      child: SizedBox(
        width: double.maxFinite,
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.scroll,
                color: MyColors.primary,
                size: 70,
              ),
              const Gap(5),
              Text(
                "gamebase.io",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Gap(50),
              SizedBox(
                width: 500,
                child: Column(
                  children: [
                    const _UsernameInput(),
                    const Gap(30),
                    const _PasswordInput(),
                    const Gap(50),
                    _LoginButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FormTextField(
          key: const Key('loginForm_usernameInput_textField'),
          label: "Email",
          autofillHints: const [AutofillHints.email, AutofillHints.username],
          required: true,
          helpText: null,
          onChanged: (username) {
            context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username.trim()));
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FormTextField(
          key: const Key('loginForm_passwordInput_textField'),
          label: "Password",
          obscureText: true,
          autofillHints: const [AutofillHints.password],
          required: true,
          helpText: null,
          onChanged: (password) {
            context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password.trim()));
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: 500,
          height: 50,
          child: TextButton(
            "Login",
            key: const Key('loginForm_continue_raisedButton'),
            styleForm: TextButtonStyleForm(
              color: MyColors.primary,
              hoverColor: MyColors.primary.withOpacity(0.8),
              focusedColor: MyColors.primary.withOpacity(0.8),
              pressedColor: MyColors.primary.withOpacity(0.8),
              fontColor: Colors.white,
            ),
            onPressed: () {
              if (state.isValid == false || state.status.isInProgress) {
                return;
              }

              context.read<LoginBloc>().add(const LoginSubmitted());
            },
          ),
        );
      },
    );
  }
}
