import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:investement_app/core/widgets/custom_button.dart';
import 'package:investement_app/features/home/data/offer_cubit.dart';
import 'package:investement_app/features/home/data/offer_state.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/models/offer_model.dart';
import 'package:investement_app/features/home/service/wishlist_services.dart';
import 'package:investement_app/gen/assets.gen.dart';

class BusinessDetailScreen extends StatefulWidget {
  final BusinessModel business;
  const BusinessDetailScreen({super.key, required this.business});

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen>
    with TickerProviderStateMixin {
  bool isWishlisted = false;
  late TabController _tabController;
  final _offerFormKey = GlobalKey<FormState>();
  double? _offeredAmount;
  double? _requestedPercentage;
  String _message = "I'm interested in investing in your business";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> handleWishlist() async {
    final success = await WishlistService.addToWishlist(widget.business.id!);
    if (success) {
      setState(() {
        isWishlisted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Added to wishlist"),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add to wishlist")),
      );
    }
  }

  void _showInvestmentDialog() {
    final cubit = context.read<OfferCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocListener<OfferCubit, OfferState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is OfferCreated) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Investment offer submitted successfully!"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
          } else if (state is OfferError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.message}"),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<OfferCubit, OfferState>(
            bloc: cubit,
            builder: (context, state) {
              return Form(
                key: _offerFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Invest in ${widget.business.businessName}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Percentage Field
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Percentage",
                        prefixIcon:
                            Icon(Icons.percent, color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter percentage';
                        final percent = double.tryParse(value);
                        if (percent == null) return 'Invalid number';
                        if (percent <= 0 || percent > 100) {
                          return 'Must be between 1-100';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          _requestedPercentage = double.parse(value!),
                    ),
                    const SizedBox(height: 16),

                    // Amount Field
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Offer Amount (\$)",
                        prefixIcon:
                            Icon(Icons.attach_money, color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Enter amount';
                        final amount = double.tryParse(value);
                        if (amount == null) return 'Invalid number';
                        if (amount <= 0) return 'Must be positive';
                        return null;
                      },
                      onSaved: (value) => _offeredAmount = double.parse(value!),
                    ),
                    const SizedBox(height: 16),

                    // Message Field
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Message",
                        prefixIcon:
                            Icon(Icons.message, color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.5),
                        ),
                      ),
                      maxLines: 3,
                      initialValue: _message,
                      onChanged: (value) => _message = value,
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    if (state is OfferCreating)
                      const CircularProgressIndicator()
                    else
                      CustomButton(
                        text: 'Submit Investment',
                        onPressed: () {
                          if (_offerFormKey.currentState!.validate()) {
                            _offerFormKey.currentState!.save();
                            final offer = OfferModel(
                              id: 0,
                              businessId: widget.business.id!,
                              offeredAmount: _offeredAmount!,
                              requestedPercentage: _requestedPercentage!,
                              message: _message,
                              parentOfferId: null,
                              investorId: 0, // Will be set from backend
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            cubit.createOffer(offer);
                          }
                        },
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final business = widget.business;
    final createdAtFormatted = DateFormat('MMMM d, y')
        .format(DateTime.parse(business.category.createdAt));

    // Get user information
    final user = business.user;
    final userName = user!.name;
    final userEmail = user.email;
    final userPhoto = user.profileImage;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 280,
              floating: false,
              pinned: true,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.blue),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted ? Colors.red : Colors.blue,
                    ),
                    onPressed: handleWishlist,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                imageUrl:
                    "http://10.0.2.2:8000/storage/${business.businessPhoto}",
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset(Assets.images.project1.path),
                fit: BoxFit.cover,
              )),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.blueAccent,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3,
                    indicatorColor: Colors.blueAccent,
                    tabs: const [
                      Tab(text: "Overview"),
                      Tab(text: "FAQ"),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Overview Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    business.description,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    business.businessName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // UPDATED USER SECTION - Shows name, photo and email
                  Row(
                    children: [
                      // User Profile Picture
                      if (userPhoto != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl: "http://10.0.2.2:8000/storage/$userPhoto",
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 48,
                              height: 48,
                              color: Colors.grey[200],
                              child: const Icon(Icons.person,
                                  size: 24, color: Colors.blueGrey),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 48,
                              height: 48,
                              color: Colors.grey[200],
                              child: const Icon(Icons.person,
                                  size: 24, color: Colors.blueGrey),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person,
                              size: 24, color: Colors.blueGrey),
                        ),

                      const SizedBox(width: 12),

                      // User Name and Email
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userEmail,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Business Details Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildDetailIcon(
                                Icons.business_center, Colors.blue),
                            const SizedBox(width: 12),
                            Text(
                              business.businessModel,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            _buildDetailIcon(Icons.location_on, Colors.red),
                            const SizedBox(width: 12),
                            Text(
                              business.location,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildDetailIcon(Icons.calendar_today, Colors.blue),
                            const SizedBox(width: 12),
                            Text(
                              createdAtFormatted,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Investment Card
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.green.shade50,
                          Colors.lightBlue.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildMetric(
                              Icons.monetization_on,
                              "Funding Needed",
                              "\$${business.moneyNeeded}",
                              Colors.green,
                            ),
                            _buildMetric(
                              Icons.people_alt_outlined,
                              "Target Market",
                              business.targetMarket,
                              Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Competitive Advantages",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          business.competitiveAdvantages,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            // FAQ Tab (Placeholder)
            const Center(
                child: Text("FAQ Content",
                    style: TextStyle(color: Colors.blueAccent))),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: CustomButton(
            text: 'Invest Now',
            onPressed: _showInvestmentDialog,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildMetric(IconData icon, String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
