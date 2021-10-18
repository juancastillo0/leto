import 'dart:async';

import 'package:chat_example/api/auth_store.dart';
import 'package:chat_example/utils/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthForm extends HookConsumerWidget {
  const AuthForm({
    Key? key,
    required this.smallForm,
  }) : super(key: key);

  final bool smallForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = useTextInput(validate: (name) {
      if (name.length < 2) {
        return 'Should be at least 2 characters long';
      }
    });
    final password = useTextInput(validate: (password) {
      if (password.length < 6) {
        return 'Should be at least 6 characters long';
      }
    });
    final state = ref.watch(authStoreProv);
    final isLoading = useListenable(state.signInLoading).value;

    final user = state.user;
    if (user != null && !state.isAnonymous) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text('logged in: ${user.name}'),
            const SizedBox(height: 4),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                ref.read(authStoreProv).signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      );
    }

    void Function()? _validated(void Function() f) {
      if (isLoading) {
        return null;
      }
      return () {
        if (password.error == null && name.error == null) {
          f();
        } else {
          name.isTouchedNotifier.value = true;
          password.isTouchedNotifier.value = true;
        }
      };
    }

    if (smallForm) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            const Text('logged out'),
            const SizedBox(height: 4),
            TextButton(
              style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                showDialog<Object?>(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(10),
                        child: const AuthForm(smallForm: false),
                      ),
                    );
                  },
                );
              },
              child: const Text('Sign In/Up'),
            )
          ],
        ),
      );
    }

    return FocusTraversalGroup(
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              const LinearProgressIndicator(minHeight: 3)
            else
              const SizedBox(height: 3),
            TextFormField(
              controller: name.controller,
              focusNode: name.focusNode,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: name.errorIfTouched,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
              onChanged: name.onChangedString,
            ),
            TextFormField(
              controller: password.controller,
              focusNode: password.focusNode,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: password.errorIfTouched,
              ),
              obscureText: true,
              onChanged: password.onChangedString,
            ),
            const SizedBox(height: 10),
            HookConsumer(builder: (context, ref, _) {
              final showError = useState(false);
              final error = useStream(
                state.errorStream,
                preserveState: false,
              );
              useEffect(() {
                if (error.hasData) {
                  showError.value = true;
                  final _timer = Timer(const Duration(seconds: 10), () {
                    showError.value = false;
                  });
                  return _timer.cancel;
                }
              }, [identityHashCode(error)]);

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: Builder(
                  key: ValueKey(showError.value),
                  builder: (context) {
                    if (showError.value) {
                      return Container(
                        color: Theme.of(context).errorColor,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          error.data!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onError,
                              ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _validated(() {
                    ref.read(authStoreProv).signUp(
                          name: name.controller.text,
                          password: password.controller.text,
                        );
                  }),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _validated(() {
                    ref.read(authStoreProv).signIn(
                          name: name.controller.text,
                          password: password.controller.text,
                        );
                  }),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
