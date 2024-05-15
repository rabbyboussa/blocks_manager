import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/productions/products/data/data_sources/products_data_source.dart';
import 'package:blocks/features/productions/products/data/models/product_model.dart';
import 'package:blocks/features/productions/products/domain/entities/product_entity.dart';
import 'package:blocks/features/productions/products/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl({required ProductsDataSource dataSource})
      : _dataSource = dataSource;

  final ProductsDataSource _dataSource;

  @override
  ResultFuture<List<ProductModel>> fetchProducts() async {
    try {
      final httpResponse = await _dataSource.fetchProducts();

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }

  @override
  ResultFuture<ProductModel> addProduct(
      {required ProductEntity product}) async {
    try {
      final httpResponse = await _dataSource.addProduct(
        body: {
          'designation': product.designation,
          'description': product.description,
          'width': product.width,
          'length': product.length,
          'height': product.height,
          'weight': product.weight,
          'unitPrice': product.unitPrice,
          'quantity': product.quantity,
          'imagePath': product.imagePath,
        },
      );

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }

  @override
  ResultFutureVoid updateProduct({required ProductEntity product}) async {
    try {
      final httpResponse = await _dataSource.updateProduct(
        body: {
          'idToUpdate': product.id,
          'newDesignation': product.designation,
          'newDescription': product.description,
          'newWidth': product.width,
          'newLength': product.length,
          'newHeight': product.height,
          'newWeight': product.weight,
          'newUnitPrice': product.unitPrice,
          'newQuantity': product.quantity,
          'newImagePath': product.imagePath,
        },
      );

      if (httpResponse.response.statusCode == 200) {
        return Right(httpResponse.data);
      } else {
        throw ApiException(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
        );
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(statusCode: e.statusCode, message: e.message));
    } catch (e) {
      return Left(ApiFailure(statusCode: 505, message: e.toString()));
    }
  }
}
