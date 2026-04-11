import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/item_categories_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'del_item_category_event.dart';
part 'del_item_category_state.dart';
part 'del_item_category_bloc.freezed.dart';

class DelItemCategoryBloc extends Bloc<DelItemCategoryEvent, DelItemCategoryState> {
  final ItemCategoriesRepository itemCategoryRepository;
  DelItemCategoryBloc(this.itemCategoryRepository) : super(_Initial()) {
    on<_DelItemCategory>((event, emit) async {
      emit(_Loading());
      final result = await itemCategoryRepository.deleteItemCategory(
        outletId: event.outletId,
        id: event.id,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (message) => emit(_Success(message)),
      );
    });
  }
}
