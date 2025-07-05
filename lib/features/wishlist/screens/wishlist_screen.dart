import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:investement_app/features/wishlist/model/wishlist_model.dart';
import 'package:investement_app/features/wishlist/service/wishlist_service.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class WishlistPage extends StatefulWidget {
  static const id = '/wishlist';
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  List<WishlistModel> wishlistItems = [];
  bool isLoading = true;
  bool hasError = false;
  Map<int, bool> expandedStates = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 0.5, curve: Curves.easeIn),
    ));

    _scaleAnimation =
        Tween<double>(begin: 0.95, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1, curve: Curves.easeOut),
    ));

    // Start animation after a small delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _animationController.forward();
      }
    });

    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final service = WishlistService(authToken: token);
      final items = await service.getWishlist();
      setState(() {
        wishlistItems = items;
        isLoading = false;
        // Initialize expanded states
        for (var item in items) {
          expandedStates[item.id] = false;
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Wishlist'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWishlist,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Failed to load wishlist'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadWishlist,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (wishlistItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('Your wishlist is empty',
                style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final item = wishlistItems[index];
        return _buildWishlistItem(item, index);
      },
    );
  }

  Widget _buildWishlistItem(WishlistModel item, int index) {
    final isExpanded = expandedStates[item.id] ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with business info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: item.business.businessPhoto == null
                            ? Icon(Icons.business, color: Colors.grey[400])
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "http://10.0.2.2:8000/storage/${item.business.businessPhoto!}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.business.businessName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.business.category.name,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          // TODO: Implement remove from wishlist
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Basic info row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoChip(
                        icon: Icons.attach_money,
                        value: '\$${item.business.valuation}',
                        label: 'Valuation',
                      ),
                      _buildInfoChip(
                        icon: Icons.location_on,
                        value: item.business.location,
                        label: 'Location',
                      ),
                      _buildInfoChip(
                        icon: Icons.calendar_today,
                        value: item.business.foundedYear?.toString() ?? 'N/A',
                        label: 'Founded',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Expandable section
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Container(),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      item.business.description,
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    const SizedBox(height: 16),
                    // More details in a grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: [
                        _buildDetailItem(
                          'Money Needed',
                          '\$${item.business.moneyNeeded}',
                        ),
                        _buildDetailItem(
                          'Equity Offered',
                          '${item.business.percentageOffered}%',
                        ),
                        _buildDetailItem(
                          'Business Model',
                          item.business.businessModel,
                        ),
                        _buildDetailItem(
                          'Target Market',
                          item.business.targetMarket,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (item.business.competitiveAdvantages.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Competitive Advantages',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(item.business.competitiveAdvantages),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            // Show more/less button
            GestureDetector(
              onTap: () {
                setState(() {
                  expandedStates[item.id] = !isExpanded;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isExpanded ? 'SHOW LESS' : 'SHOW MORE',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: isExpanded ? 0.5 : 0,
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
      {required IconData icon, required String value, required String label}) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
