import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class DonationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donations Page',
      theme: ThemeData(primarySwatch: Colors.green),
      home: DonationsPage(),
    );
  }
}

class DonationsPage extends StatefulWidget {
  @override
  _DonationsPageState createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  Uint8List? _img;
  bool _addLocation = false;
  List<String> ingredients = [];
  List<String> allergens = [];
  String? _selectedCategory;
  final List<String> categories = ["Packed Food", "Perishables", "Others"];

  final ImagePicker _imagePicker = ImagePicker();

  // Function to pick an image either from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      XFile? _file = await _imagePicker.pickImage(source: source);

      if (_file != null) {
        Uint8List imageData = await _file.readAsBytes();

        setState(() {
          _img = imageData;
        });
      } else {
        print('No Image Selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Show dialog to select between camera or gallery
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "FOOD MANAGEMENT",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Image upload section
                  GestureDetector(
                    onTap:
                        _showImageSourceDialog, // Show the dialog when tapped
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          backgroundImage:
                              _img != null ? MemoryImage(_img!) : null,
                          child: _img == null
                              ? const Icon(Icons.camera_alt,
                                  size: 50, color: Colors.grey)
                              : null,
                        ),
                        const Positioned(
                          bottom: 8,
                          right: 8,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.green,
                            child:
                                Icon(Icons.add, size: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Category dropdown
                  _buildDropdownField("Category", categories, _selectedCategory,
                      (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
                  const SizedBox(height: 20),
                  // Product name and expiry date
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _productNameController,
                          label: 'Product name',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildTextField(
                          controller: _expiryDateController,
                          label: 'Expiry date',
                          isDate: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Latitude and Longitude
                  Row(
                    children: [
                      Checkbox(
                        value:
                            _addLocation, // Boolean variable to track checkbox state
                        onChanged: (value) {
                          setState(() {
                            _addLocation = value ?? false;
                          });
                        },
                      ),
                      const Text('Add Location'),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // Ingredients and Allergic sections with subtle distinction
                  _buildAddItemSection(
                    'Ingredients',
                    ingredients,
                    hint: 'Add an Ingredient (optional)',
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(height: 20),
                  _buildAddItemSection(
                    'Alergic to',
                    allergens,
                    hint: 'Add an Allergy (optional)',
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [Colors.greenAccent, Colors.yellowAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Text('Log Food',
                            style: TextStyle(color: Colors.black)),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [Colors.greenAccent, Colors.yellowAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Text('Donate Food',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String? selectedValue, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isNumber = false,
    bool isDate = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        keyboardType: isNumber
            ? TextInputType.number
            : isDate
                ? TextInputType.datetime
                : TextInputType.text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildAddItemSection(String title, List<String> items,
      {required String hint, Color? backgroundColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            IconButton(
              icon: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 204, 255, 205)),
                  child: Text('Add',
                      style: TextStyle(color: Colors.black, fontSize: 14))),
              onPressed: () => _showAddItemDialog(title, items, hint),
            ),
          ],
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: items.isNotEmpty
              ? items.map((item) {
                  return Chip(
                    label: Text(item),
                    backgroundColor:
                        backgroundColor ?? Colors.greenAccent.withOpacity(0.3),
                    deleteIconColor: Colors.red,
                    onDeleted: () {
                      setState(() {
                        items.remove(item);
                      });
                    },
                  );
                }).toList()
              : [Text('No $title Added')],
        ),
      ],
    );
  }

  void _showAddItemDialog(String title, List<String> items, String hint) {
    TextEditingController _itemController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add $title'),
          content: TextField(
            controller: _itemController,
            decoration: InputDecoration(
              hintText: hint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  items.add(_itemController.text);
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
