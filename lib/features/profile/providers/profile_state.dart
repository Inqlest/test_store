import 'package:test_store/features/profile/model/user.dart';

class ProfileState {
  final User? user;
  final bool isLoading;

  ProfileState({this.user, this.isLoading = true});

  ProfileState copyWith({User? user, bool? isLoading}) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
