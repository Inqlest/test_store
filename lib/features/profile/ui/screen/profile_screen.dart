import 'package:flutter/material.dart';
import 'package:test_store/features/profile/providers/profile_provider.dart';
import 'package:test_store/navigation_bar/navigation_bar.dart';
import 'package:test_store/res/constants/font_constants.dart';
import 'package:test_store/features/profile/ui/widgets/account_action.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const profilePhotoUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwRgakMKueaRTq-2cE5TbdAFGIKlVwPGNK2w&s';

@RoutePage()
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(profileProvider.notifier).fetchUserProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: profileState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profilePhotoUrl),
                          ),
                          const SizedBox(width: 31.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${profileState.user?.firstName ?? ''} ${profileState.user?.secondName ?? ''}',
                                style: smallTitleTextStyle,
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 550),
                    AccountAction(
                      title: 'Выйти из аккаунта',
                      onTap: () {
                        ref.read(profileProvider.notifier).logout(context);
                      },
                    ),
                    const SizedBox(height: 12),
                    AccountAction(
                      title: 'Удалить аккаунт',
                      onTap: () {
                        ref.read(profileProvider.notifier).deleteUser(context);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
