import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:investement_app/features/home/screens/buissness_deatil_screen.dart';
import 'package:investement_app/features/myBuisness/screens/my_buissness.dart';
import 'package:investement_app/features/profile/data/profile_cubit.dart';
import 'package:investement_app/gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..getProfile(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileFailure) {
              return Center(child: Text(state.message));
            } else if (state is ProfileSuccess) {
              final user = state.profile;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[200],
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://10.0.2.2:8000/storage/${user.profileImage}',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (_, __, ___) => Image.asset(
                                Assets.images.profilePhoto.path,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  _readOnlyField('Full Name', user.name ?? ''),
                  const SizedBox(height: 15),
                  _readOnlyField('User Name', user.name ?? 'Not Set'),
                  const SizedBox(height: 15),
                  _readOnlyField('Phone Number', user.phone ?? 'Not set '),
                  const SizedBox(height: 15),
                  _readOnlyField('Email', user.email ?? ''),
                  const SizedBox(height: 15),
                  // _readOnlyField('Password', '********'),
                  const SizedBox(height: 40),
                  // Container(
                  //   height: 60,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(30),
                  //     gradient: const LinearGradient(
                  //       colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //     ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.blueAccent.withOpacity(0.3),
                  //         offset: const Offset(0, 10),
                  //         blurRadius: 10,
                  //       ),
                  //     ],
                  //   ),
                  //   child: const Center(
                  //     child: Text(
                  //       'Edit',
                  //       style: TextStyle(
                  //         fontSize: 22,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MyBusinessesScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'My Investments',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _readOnlyField(String label, String value) {
    return TextFormField(
      readOnly: true,
      initialValue: value,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
