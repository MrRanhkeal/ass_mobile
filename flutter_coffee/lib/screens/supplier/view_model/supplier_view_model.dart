import 'package:flutter_coffee/data/remote/models/request/Post_base_request.dart';
import 'package:flutter_coffee/data/remote/models/response/base_body_response.dart';
import 'package:flutter_coffee/data/remote/models/response/Supplier_response.dart';
import 'package:flutter_coffee/data/remote/repositories/impl/article_repository_impl.dart';
import 'package:flutter_coffee/enum/status.dart';
import 'package:get/get.dart';

class SupplierViewModel extends GetxController {
  var articleRepo = ArticleRepositoryImpl();
  var loadingStatus = Status.loading.obs;
  var suppliersList = <SupplierResponse>[].obs;

  setLoadingStatus(Status value) => loadingStatus = value.obs;

  @override
  void onInit() {
    getAllSuppliers();
    super.onInit();
  }

  Future<void> createSupplier({
    required String name,
    required String productType,
    required String code,
    required String phone,
    required String email,
    required String address,
    String? description,
  }) async {
    try {
      setLoadingStatus(Status.loading);
      
      final request = PostBaseRequest(data: {
        'name': name,
        'productType': productType,
        'code': code,
        'phone': phone,
        'email': email,
        'address': address,
        if (description != null && description.isNotEmpty)
          'description': description,
      });

      final response = await articleRepo.createSupplier(request);
      
      if (response.isSuccess) {
        Get.back(); // Close the dialog
        Get.snackbar(
          'Success',
          'Supplier created successfully',
          snackPosition: SnackPosition.TOP,
        );
        getAllSuppliers(); // Refresh the list
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to create supplier',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while creating the supplier',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setLoadingStatus(Status.success);
    }
  }

  Future<void> getAllSuppliers() async {
    try {
      setLoadingStatus(Status.loading);
      var req = PostBaseRequest();
      var response = await articleRepo.getAllSuppliers(req);
      if (response.isSuccess && response.body != null) {
        suppliersList.clear();
        (response.body as List).forEach((data) {
          suppliersList.add(SupplierResponse.fromJson(data));
        });
        setLoadingStatus(Status.success);
      } else {
        setLoadingStatus(Status.error);
      }
    } catch (e) {
      setLoadingStatus(Status.error);
    }
  }

  Future<void> updateSupplier({
    required String id,
    required String name,
    required String productType,
    required String code,
    required String phone,
    required String email,
    required String address,
    String? description,
  }) async {
    try {
      setLoadingStatus(Status.loading);
      
      final request = PostBaseRequest(data: {
        'id': id,
        'name': name,
        'productType': productType,
        'code': code,
        'phone': phone,
        'email': email,
        'address': address,
        if (description != null && description.isNotEmpty)
          'description': description,
      });

      final response = await articleRepo.updateSupplier(request);
      
      if (response.isSuccess) {
        Get.back(); // Close the dialog
        Get.snackbar(
          'Success',
          'Supplier updated successfully',
          snackPosition: SnackPosition.TOP,
        );
        getAllSuppliers(); // Refresh the list
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to update supplier',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while updating the supplier',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setLoadingStatus(Status.success);
    }
  }

  Future<void> deleteSupplier(String id) async {
    try {
      setLoadingStatus(Status.loading);
      
      final request = PostBaseRequest(data: {'id': id});
      final response = await articleRepo.deleteSupplier(request);
      
      if (response.isSuccess) {
        Get.snackbar(
          'Success',
          'Supplier deleted successfully',
          snackPosition: SnackPosition.TOP,
        );
        getAllSuppliers(); // Refresh the list
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to delete supplier',
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while deleting the supplier',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setLoadingStatus(Status.success);
    }
  }
}
