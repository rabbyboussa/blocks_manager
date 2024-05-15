import 'package:bloc/bloc.dart';
import 'package:blocks/core/constants/constants.dart';
import 'package:blocks/core/services/injection_container.dart';
import 'package:blocks/features/administration/employees/domain/entities/employee_entity.dart';
import 'package:blocks/features/administration/employees/domain/usecases/add_employee_usecase.dart';
import 'package:blocks/features/administration/employees/domain/usecases/update_employee_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_employee_event.dart';
part 'edit_employee_state.dart';

class EditEmployeeBloc extends Bloc<EditEmployeeEvent, EditEmployeeState> {
  EditEmployeeBloc({
    required AddEmployeeUsecase addEmployeeUsecase,
    required UpdateEmployeeUsecase updateEmployeeUsecase,
  })  : _addEmployeeUsecase = addEmployeeUsecase,
        _updateEmployeeUsecase = updateEmployeeUsecase,
        super(EditEmployeeInitial()) {
    on<EditEvent>(onEditing);
  }

  final AddEmployeeUsecase _addEmployeeUsecase;
  final UpdateEmployeeUsecase _updateEmployeeUsecase;

  Future<void> onEditing(
      EditEvent event, Emitter<EditEmployeeState> emit) async {
    emit(EditEmployeeLoadingState());

    try {
      String? imageUrl;

      if (event.employee.imagePath != null) {
        imageUrl = await uploadImageToStorage(sl(), event.employee.imagePath!);
      }

      EmployeeEntity employee = event.employee.copyWith(imagePath: imageUrl);

      if (event.modification) {
        final result = await _updateEmployeeUsecase(
            UpdateEmployeeUsecaseParams(employee: employee));

        result.fold(
          (failure) {
            emit(EditEmployeeFailedState(message: failure.message));
          },
          (_) {
            emit(
              EditEmployeeDoneState(
                employee: employee,
                modification: true,
              ),
            );
          },
        );
      } else {
        final result = await _addEmployeeUsecase(
            AddEmployeeUsecaseParams(employee: employee));

        result.fold(
          (failure) {
            emit(EditEmployeeFailedState(message: failure.message));
          },
          (employee) {
            emit(
              EditEmployeeDoneState(employee: employee),
            );
          },
        );
      }
    } catch (e) {
      emit(EditEmployeeFailedState(message: e.toString()));
    }
  }
}
