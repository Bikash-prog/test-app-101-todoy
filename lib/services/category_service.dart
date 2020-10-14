import 'package:todoy/models/category.dart';
import 'package:todoy/repositories/repository.dart';

class CategoryService {
  // Repository _repository
  Repository _repository = Repository();
  // CategoryService(){
  //   _repository = Repository();
  // }
  saveCategory(Category category) async{
      return await _repository.save('categories',category.categoryMap());
  }

  getCategories() async {
    return await _repository.getAll('categories');
  }

  getCategoryById(categoryId) async {
    return await _repository.getById('categories',categoryId);
  }

  updateCategory(Category category) async {
    return await _repository.update('categories', category.categoryMap());
  }

  deleteCategory(categoryId) async {
    await _repository.delete('categories', categoryId);
  }
}