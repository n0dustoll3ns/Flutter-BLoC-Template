/* ---  States   --- */

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsFailure extends ProductsState {
  final String error;

  const ProductsFailure({required this.error});

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ProductsUpdated extends ProductsState {}

/* ---  Events   --- */

abstract class ProductsEvent {
  const ProductsEvent();
}

class ProductsRequest extends ProductsEvent {
  // final int skipCount;

  const ProductsRequest();

  @override
  String toString() => 'Products requested.';
}

class ProductsPageEnter extends ProductsEvent {}
