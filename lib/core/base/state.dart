abstract class ViewState {}

class LoadingState extends ViewState {}

class LoadedState extends ViewState {}

class ErrorState extends ViewState {
  final String message;
  ErrorState(this.message);
}
