import 'package:hooks_riverpod/hooks_riverpod.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });
}

class UserState {
  final User? currentUser;
  final bool isAuthenticated;

  const UserState({
    this.currentUser,
    required this.isAuthenticated,
  });

  UserState copyWith({
    User? currentUser,
    bool? isAuthenticated,
  }) {
    return UserState(
      currentUser: currentUser ?? this.currentUser,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class UserStore extends StateNotifier<UserState> {
  UserStore()
      : super(
          const UserState(
            currentUser: null,
            isAuthenticated: false,
          ),
        );

  void login(User user) {
    state = state.copyWith(
      currentUser: user,
      isAuthenticated: true,
    );
  }

  void logout() {
    state = state.copyWith(
      currentUser: null,
      isAuthenticated: false,
    );
  }

  void updateUser(User user) {
    state = state.copyWith(currentUser: user);
  }
}

final userStoreProvider = StateNotifierProvider<UserStore, UserState>(
  (ref) => UserStore(),
);