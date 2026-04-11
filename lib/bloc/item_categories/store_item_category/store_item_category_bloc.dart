import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/item_categories_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_item_category_event.dart';
part 'store_item_category_state.dart';
part 'store_item_category_bloc.freezed.dart';

class StoreItemCategoryBloc extends Bloc<StoreItemCategoryEvent, StoreItemCategoryState> {
  final ItemCategoriesRepository itemCategoryRepository;

  StoreItemCategoryBloc(this.itemCategoryRepository) : super(_Initial()) {
    on<_StoreItemCategory>((event, emit) async{
      emit(_Loading());
      final result = await itemCategoryRepository.storeItemCategory(
        outletId: event.outletId,
        name: event.name,
      );
      result.fold(
        (failure) => emit(_Error(failure)),
        (success) => emit(_Success("Item category created successfully")),
      );
    });
  }
}
