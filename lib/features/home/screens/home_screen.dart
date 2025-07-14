import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/models/category_model.dart';
import 'package:investement_app/features/home/service/api_service.dart';
import 'package:investement_app/features/home/widgets/card_list_view.dart';
import 'package:investement_app/features/home/widgets/darwer_list_tile.dart';
import 'package:investement_app/features/home/widgets/menu_list.dart';
import 'package:investement_app/features/home/widgets/profile_widget.dart';
import 'package:investement_app/features/home/widgets/text_field.dart';
import 'package:investement_app/features/profile/Screens/profile_screen.dart';
import 'package:investement_app/features/profile/models/profile_model.dart';
import 'package:investement_app/features/profile/service/profile_service.dart';
import 'package:investement_app/gen/assets.gen.dart';

class Homepage extends StatefulWidget {
  static const String id = "/home";
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService api = ApiService();
  late Future<List<CategoryModel>> futureCats;

  List<CategoryModel> allCats = [];
  CategoryModel? selectedCat;
  List<BusinessModel> businesses = [];

  bool loadingBiz = false;
  String searchText = "";
  ProfileModel? userProfile;

  @override
  void initState() {
    super.initState();
    futureCats = api.getCategories();
    fetchBusinesses();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile = await ProfileService.getProfile();
    if (mounted) {
      setState(() => userProfile = profile);
    }
  }

  Future<void> fetchBusinesses({int? catId, String? query}) async {
    setState(() => loadingBiz = true);
    try {
      businesses =
          await api.getBusinesses(categoryId: catId, searchQuery: query);
    } catch (e) {
      businesses = [];
    }
    setState(() => loadingBiz = false);
  }

  void _onSearch(String query) {
    searchText = query;
    fetchBusinesses(catId: selectedCat?.id, query: query);
  }

  void _onFilter(CategoryModel? cat) {
    setState(() => selectedCat = cat);
    fetchBusinesses(catId: cat?.id, query: searchText);
  }

  @override
  Widget build(BuildContext ctx) {
    final size = MediaQuery.of(ctx).size;

    return FutureBuilder<List<CategoryModel>>(
      future: futureCats,
      builder: (c, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (snap.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snap.error}')));
        }

        allCats = snap.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'FundX',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(ctx,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: size.width * 0.02),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(150)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.network(
                      "http://10.0.2.2:8000/storage/${userProfile?.profileImage ?? ''}",
                      height: size.height * 0.05,
                      width: size.width * 0.1,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets.images.profilePhoto.path,
                          height: size.height * 0.05,
                          width: size.width * 0.1,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20),
                DrawerListtile(
                  onTap: () {
                    context.pop();
                  },
                  title: const Text('Menu',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  icon: const Icon(Icons.close),
                  traillerIcon: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const SizedBox(height: 20),
                ProfileWidget(profileImage: userProfile?.profileImage),
                MenuList(
                  userProfile: userProfile,
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      label: 'Search Any project',
                      icon: Icons.search,
                      onChanged: _onSearch,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All Projects',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 120,
                          child: DropdownButtonFormField<CategoryModel?>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: '',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            items: [
                              const DropdownMenuItem<CategoryModel?>(
                                value: null,
                                child: Text(
                                  "All",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ...allCats.map(
                                (cat) => DropdownMenuItem<CategoryModel?>(
                                  value: cat,
                                  child: Text(
                                    cat.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                            value: selectedCat,
                            onChanged: _onFilter,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: loadingBiz
                    ? const Center(child: CircularProgressIndicator())
                    : businesses.isEmpty
                        ? const Center(child: Text("No projects found."))
                        : CardListView(cards: businesses),
              )
            ],
          ),
        );
      },
    );
  }
}
