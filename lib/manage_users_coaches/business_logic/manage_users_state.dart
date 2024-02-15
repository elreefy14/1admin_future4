part of '../../../manage_users_coaches/business_logic/manage_users_cubit.dart';

@immutable
abstract class ManageUsersState {}

class ManageSalaryInitial extends ManageUsersState {}
//GetUsersLoadingState
class GetUsersLoadingState extends ManageUsersState {}
//GetUsersSuccessState
class GetUsersSuccessState extends ManageUsersState {}
//GetUsersErrorState
class GetUsersErrorState extends ManageUsersState {
  final String error;
  GetUsersErrorState(this.error);
}
//PaySalaryLoadingState
class PaySalaryLoadingState extends ManageUsersState {}
//PaySalarySuccessState
class PaySalarySuccessState extends ManageUsersState {}
//PaySalaryErrorState
class PaySalaryErrorState extends ManageUsersState {
  final String error;
  PaySalaryErrorState(this.error);
}
//PayBonusLoadingState
class PayBonusLoadingState extends ManageUsersState {}
//PayBonusSuccessState
class PayBonusSuccessState extends ManageUsersState {}
//PayBonusErrorState
class PayBonusErrorState extends ManageUsersState {
  final String error;
  PayBonusErrorState(this.error);
}
//PayBonusSuccessStateWithoutInternet
class PayBonusSuccessStateWithoutInternet extends ManageUsersState {}
//Stop
class Stop extends ManageUsersState {}
//PaySalarySuccessStateWithoutInternet
class PaySalarySuccessStateWithoutInternet extends ManageUsersState {}
//UpdateUserInfoLoadingState
class UpdateUserInfoLoadingState extends ManageUsersState {}
//UpdateUserInfoSuccessState
class UpdateUserInfoSuccessState extends ManageUsersState {}
//UpdateUserInfoErrorState
class UpdateUserInfoErrorState extends ManageUsersState {
  final String error;
  UpdateUserInfoErrorState(this.error);
}
//GetSchedulesLoadingState
class GetSchedulesLoadingState extends ManageUsersState {}
//GetSchedulesSuccessState
class GetSchedulesSuccessState extends ManageUsersState {}
//GetSchedulesErrorState
class GetSchedulesErrorState extends ManageUsersState {
  final String error;
  GetSchedulesErrorState(this.error);
}
//GenerateRandomSchedulesLoadingState
class GenerateRandomSchedulesLoadingState extends ManageUsersState {}
//GenerateRandomSchedulesSuccessState
class GenerateRandomSchedulesSuccessState extends ManageUsersState {}
//GenerateRandomSchedulesErrorState
class GenerateRandomSchedulesErrorState extends ManageUsersState {
  final String error;
  GenerateRandomSchedulesErrorState(this.error);
}
//GetSchedulesForDayLoadingState
class GetSchedulesForDayLoadingState extends ManageUsersState {}
//GetSchedulesForDaySuccessState
class GetSchedulesForDaySuccessState extends ManageUsersState {}
//GetSchedulesForDayErrorState
class GetSchedulesForDayErrorState extends ManageUsersState {
  final String error;
  GetSchedulesForDayErrorState(this.error);
}
//DeleteScheduleLoadingState
class DeleteScheduleLoadingState extends ManageUsersState {}
//DeleteScheduleSuccessState
class DeleteScheduleSuccessState extends ManageUsersState {}
//DeleteScheduleErrorState
class DeleteScheduleErrorState extends ManageUsersState {
  final String error;
  DeleteScheduleErrorState(this.error);
}
//ChangeSelectedDayIndexState
class ChangeSelectedDayIndexState extends ManageUsersState {
  final int selectedDayIndex;
  ChangeSelectedDayIndexState(this.selectedDayIndex);
}//UpdateSchedulesLoadingState
//UpdateSchedulesLoadingState
class UpdateSchedulesLoadingState extends ManageUsersState {}
//UpdateSchedulesSuccessState
class UpdateSchedulesSuccessState extends ManageUsersState {}
//ChangeIsGreyState
class ChangeIsGreyState extends ManageUsersState {
  final bool isGrey;
  ChangeIsGreyState(this.isGrey);
}//UpdateListOfUsersState
//UpdateListOfUsersState
class UpdateListOfUsersState extends ManageUsersState {
  final List<UserModel> listOfUsers;
  UpdateListOfUsersState(this.listOfUsers);
}//UpdateListOfSchedulesState
//ChangeIsCoachState
class ChangeIsCoachState extends ManageUsersState {
  final bool isCoach;
  ChangeIsCoachState(this.isCoach);
}//UpdateListOfSchedulesState
//ShowRollbackButtonState
class ShowRollbackButtonState extends ManageUsersState {
  
}//UpdateListOfSchedulesState
//UpdateShowRollbackButtonLoadingState
class UpdateShowRollbackButtonLoadingState extends ManageUsersState {
  
}//UpdateListOfSchedulesState
//UpdateShowRollbackButtonSuccessState
class UpdateShowRollbackButtonSuccessState extends ManageUsersState {
  
}//UpdateListOfSchedul// esState
//DeleteUserLoadingState
class DeleteUserLoadingState extends ManageUsersState {

}//UpdateListOfSchedulesState
//DeleteUserSuccessState
class DeleteUserSuccessState extends ManageUsersState {

}//UpdateListOfSchedulesState
//DeleteUserErrorState
class DeleteUserErrorState extends ManageUsersState {
  final String error;
  DeleteUserErrorState(this.error);
}//UpdateListOfSchedulesState
//ReduceSessionsLoadingState
class ReduceSessionsLoadingState extends ManageUsersState {

}//UpdateListOfSchedulesState
//ReduceSessionsSuccessState
class ReduceSessionsSuccessState extends ManageUsersState {

}//UpdateListOfSchedulesState
//ReduceSessionsErrorState
class ReduceSessionsErrorState extends ManageUsersState {
  final String error;
  ReduceSessionsErrorState(this.error);
}//UpdateListOfSchedulesState
//AddSessionsLoadingState
class AddSessionsLoadingState extends ManageUsersState {

}//UpdateListOfSchedulesState
//AddSessionsSuccessState
class AddSessionsSuccessState extends ManageUsersState {

}//UpdateListOfSchedulesState
//AddSessionsErrorState
class AddSessionsErrorState extends ManageUsersState {
  final String error;
  AddSessionsErrorState(this.error);
}//UpdateListOfSchedulesState
//RollbackSalarySuccessStateWithoutInternet
class RollbackSalarySuccessStateWithoutInternet extends ManageUsersState {

}//UpdateListOfSchedulesState
//ChangeSelectedBranchIndexState
class ChangeSelectedBranchIndexState extends ManageUsersState {
  //final int selectedBranchIndex;
 // ChangeSelectedBranchIndexState(this.selectedBranchIndex);
}//Upda
// teListOfSchedulesState
//GetBranchesLoadingState
class GetBranchesLoadingState extends ManageUsersState {

}//UpdateListOfSchedulesState
//GetBranchesSuccessState
class GetBranchesSuccessState extends ManageUsersState {
  final List<BranchModel> branches;
  GetBranchesSuccessState(this.branches);
}//UpdateListOfSchedulesState
//GetBranchesErrorState
class GetBranchesErrorState extends ManageUsersState {
  final String error;
  GetBranchesErrorState(this.error);
}//UpdateListOfSchedulesState
//DeleteGroupLoadingState
class DeleteGroupLoadingState extends ManageUsersState {

}//UpdateListOfSchedulesState
//DeleteGroupSuccessState
class DeleteGroupSuccessState extends ManageUsersState {

}//UpdateListOfSchedulesState
//DeleteGroupErrorState
class DeleteGroupErrorState extends ManageUsersState {
  final String error;
  DeleteGroupErrorState(this.error);
}//UpdateListOfSchedulesState
//GetDaysLoadingState
class GetDaysLoadingState extends ManageUsersState {

}//UpdateListOfSchedulesState
//GetDaysSuccessState
class GetDaysSuccessState extends ManageUsersState {

}//UpdateListOfSchedulesState
//PayAllSalaryLoadingState
class PayAllSalaryLoadingState extends ManageUsersState {

}//UpdateListOfSchedulesState