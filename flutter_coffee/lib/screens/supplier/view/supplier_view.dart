import 'package:flutter/material.dart';
import 'package:flutter_coffee/screens/supplier/view_model/supplier_view_model.dart';
import 'package:get/get.dart';

class SupplierView extends StatefulWidget {
  const SupplierView({Key? key}) : super(key: key);

  @override
  State<SupplierView> createState() => _SupplierViewState();
}

class _SupplierViewState extends State<SupplierView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedProductType;

  final viewModel = Get.put(SupplierViewModel());

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Supplier',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildRequiredTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'Enter supplier name',
              ),
              const SizedBox(height: 16),
              _buildProductTypeDropdown(),
              const SizedBox(height: 16),
              _buildRequiredTextField(
                controller: _codeController,
                label: 'Code',
                hint: 'Enter supplier code',
              ),
              const SizedBox(height: 16),
              _buildRequiredTextField(
                controller: _phoneController,
                label: 'Phone',
                hint: 'Enter phone number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!RegExp(r'^[0-9]{9,10}$').hasMatch(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildRequiredTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildRequiredTextField(
                controller: _addressController,
                label: 'Address',
                hint: 'Enter full address',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                hint: 'Description',
                maxLines: 3,
                required: false,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _saveSupplier,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequiredTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return _buildTextField(
      controller: controller,
      label: label,
      hint: hint,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      required: true,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
    required bool required,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(color: Colors.black87),
              ),
              if (required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator ?? (required
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '$label is required';
                  }
                  return null;
                }
              : null),
        ),
      ],
    );
  }

  Widget _buildProductTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const RichText(
        //   text: TextSpan(
        //     children: [
        //       TextSpan(
        //         text: 'Product Type',
        //         style: TextStyle(color: Colors.black87),
        //       ),
        //       TextSpan(
        //         text: ' *',
        //         style: TextStyle(color: Colors.red),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedProductType,
          decoration: InputDecoration(
            hintText: 'Select product type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 'Coffee', child: Text('Coffee')),
            DropdownMenuItem(value: 'Tea', child: Text('Tea')),
            DropdownMenuItem(value: 'Milk', child: Text('Milk')),
            DropdownMenuItem(value: 'Syrup', child: Text('Syrup')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedProductType = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Product type is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _saveSupplier() {
    if (_formKey.currentState!.validate()) {
      viewModel.createSupplier(
        name: _nameController.text,
        productType: _selectedProductType!,
        code: _codeController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        description: _descriptionController.text,
      );
    }
  }
}
