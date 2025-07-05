import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:investement_app/features/home/models/buissnesses_model.dart';
import 'package:investement_app/features/home/models/category_model.dart';
import 'package:investement_app/features/projects/service/create_project_service.dart';

class BusinessFormPage extends StatefulWidget {
  static const id = '/buisnessForm';
  @override
  _BusinessFormPageState createState() => _BusinessFormPageState();
}

class _BusinessFormPageState extends State<BusinessFormPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateAnimation;

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _valuationController = TextEditingController();
  final TextEditingController _moneyNeededController = TextEditingController();
  final TextEditingController _percentageOfferedController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _employeesCountController =
      TextEditingController();
  final TextEditingController _foundedYearController = TextEditingController();
  final TextEditingController _businessModelController =
      TextEditingController();
  final TextEditingController _targetMarketController = TextEditingController();
  final TextEditingController _competitiveAdvantagesController =
      TextEditingController();

  String _categoryId = '';
  String _businessPhotoPath = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    _translateAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _businessNameController.dispose();
    _descriptionController.dispose();
    _valuationController.dispose();
    _moneyNeededController.dispose();
    _percentageOfferedController.dispose();
    _locationController.dispose();
    _employeesCountController.dispose();
    _foundedYearController.dispose();
    _businessModelController.dispose();
    _targetMarketController.dispose();
    _competitiveAdvantagesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _businessPhotoPath = pickedFile.path;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final business = BusinessModel(
      id: null,
      user: null, 
      userId: null,
      categoryId: int.tryParse(_categoryId),
      businessName: _businessNameController.text,
      description: _descriptionController.text,
      businessPhoto: _businessPhotoPath.isNotEmpty ? _businessPhotoPath : null,
      valuation: _valuationController.text,
      moneyNeeded: _moneyNeededController.text,
      percentageOffered: _percentageOfferedController.text,
      location: _locationController.text,
      employeesCount: int.tryParse(_employeesCountController.text),
      foundedYear: int.tryParse(_foundedYearController.text),
      businessModel: _businessModelController.text,
      targetMarket: _targetMarketController.text,
      competitiveAdvantages: _competitiveAdvantagesController.text,
      isActive: true,
      category: CategoryModel(
        id: 0,
        name: '',
        slug: '',
        description: '',
        createdAt: '',
        updatedAt: '',
        businessesCount: 0,
      ),
    );

    try {
      await ApiService.createBusiness(business);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Business created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _formKey.currentState!.reset();
      setState(() {
        _businessPhotoPath = '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create business: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Business'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.translate(
              offset: Offset(0, _translateAnimation.value),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Business Photo
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            image: _businessPhotoPath.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(File(_businessPhotoPath)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _businessPhotoPath.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo,
                                        size: 40, color: Colors.grey[600]),
                                    SizedBox(height: 8),
                                    Text('Add Business Photo',
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                  ],
                                )
                              : null,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Business Name
                      TextFormField(
                        controller: _businessNameController,
                        decoration: InputDecoration(
                          labelText: 'Business Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.business),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a business name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Valuation
                      TextFormField(
                        controller: _valuationController,
                        decoration: InputDecoration(
                          labelText: 'Valuation',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the valuation';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Money Needed
                      TextFormField(
                        controller: _moneyNeededController,
                        decoration: InputDecoration(
                          labelText: 'Money Needed',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the amount needed';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Percentage Offered
                      TextFormField(
                        controller: _percentageOfferedController,
                        decoration: InputDecoration(
                          labelText: 'Percentage Offered',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.percent),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the percentage offered';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Location
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Employees Count
                      TextFormField(
                        controller: _employeesCountController,
                        decoration: InputDecoration(
                          labelText: 'Employees Count',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.people),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of employees';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Founded Year
                      TextFormField(
                        controller: _foundedYearController,
                        decoration: InputDecoration(
                          labelText: 'Founded Year',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the founded year';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Business Model
                      TextFormField(
                        controller: _businessModelController,
                        decoration: InputDecoration(
                          labelText: 'Business Model',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.model_training),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the business model';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Target Market
                      TextFormField(
                        controller: _targetMarketController,
                        decoration: InputDecoration(
                          labelText: 'Target Market',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.people_outline),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the target market';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Competitive Advantages
                      TextFormField(
                        controller: _competitiveAdvantagesController,
                        decoration: InputDecoration(
                          labelText: 'Competitive Advantages',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.star),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the competitive advantages';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                'Submit Business',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
