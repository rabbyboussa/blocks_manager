import 'package:blocks/core/errors/exception.dart';
import 'package:blocks/core/errors/failure.dart';
import 'package:blocks/core/typedef/typedef.dart';
import 'package:blocks/features/supplies/materials/data/data_sources/materials_data_source.dart';
import 'package:blocks/features/supplies/materials/data/models/material_model.dart';
import 'package:blocks/features/supplies/materials/domain/entities/material_entity.dart';
import 'package:blocks/features/supplies/materials/domain/repositories/materials_repository.dart';
import 'package:dartz/dartz.dart';

class MaterialsRepositoryImpl implements MaterialsRepository {
  MaterialsRepositoryImpl({required MaterialsDataSource dataSource})
      : _dataSource = dataSource;

  final MaterialsDataSource _dataSource;

  @override
  ResultFuture<List<MaterialModel>> fetchMaterials() async {
    try {
      final httpResponse = await _dataSource.fetchMaterials();

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
  ResultFuture<MaterialModel> addMaterial(
      {required MaterialEntity material}) async {
    try {
      final httpResponse = await _dataSource.addMaterial(
        body: {
          'designation': material.designation,
          'measurementUnit': material.measurementUnit,
          'quantity': material.quantity,
          'description': material.description,
          'imagePath': material.imagePath,
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
  ResultFutureVoid updateMaterial({required MaterialEntity material}) async {
    try {
      final httpResponse = await _dataSource.updateMaterial(
        body: {
          'idToUpdate': material.id,
          'newDesignation': material.designation,
          'newMeasurementUnit': material.measurementUnit,
          'newQuantity': material.quantity,
          'newDescription': material.description,
          'newImagePath': material.imagePath,
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
