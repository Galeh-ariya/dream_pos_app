import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/response/item_category_response_model.dart';
import 'package:dream_pos/data/repositories/item_categories_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item_category_event.dart';
part 'list_item_category_state.dart';
part 'list_item_category_bloc.freezed.dart';

class ListItemCategoryBloc extends Bloc<ListItemCategoryEvent, ListItemCategoryState> {
  final ItemCategoriesRepository itemCategoryRepository;

  ListItemCategoryBloc(this.itemCategoryRepository) : super(_Initial()) {
    on<_FetchItemCategories>((event, emit) async {
      emit(_Loading());
      final result = await itemCategoryRepository.fetchItemCategories(event.outletId);
      result.fold(
        (error) => emit(_Error(error)),
        (categories) => emit(_Success(categories)),
      );
    });
  }
}
