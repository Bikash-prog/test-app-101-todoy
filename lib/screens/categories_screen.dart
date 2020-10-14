
import 'package:flutter/material.dart';
import 'package:todoy/home_screen.dart';
import 'package:todoy/models/category.dart';
import 'package:todoy/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = List<Category>();

  var _editCategoryName = TextEditingController();

  var _editCategoryDescription = TextEditingController();

  var category;


  void initState() {
    super.initState();
    getAllCategories();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
      setState(() {
        var model = Category();
        model.name = category['name'];
        model.description = category['description'];
        model.id = category['id'];
        _categoryList.add(model);
      });
    });
  }

  _showFormInDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  _category.name = _categoryName.text;
                  _category.description = _categoryDescription.text;
                  var result = await _categoryService.saveCategory(_category);
                  if(result > 0) {
                    Navigator.pop(context);
                  }
                  print(result);
                },
                child: Text('Save'),
              )
            ],
            title: Text('Category form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryName,
                    decoration: InputDecoration(
                        labelText: 'Category name',
                        hintText: 'Write category name'),
                  ),
                  TextField(
                    controller: _categoryDescription,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: 'Category description',
                        hintText: 'Write category description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _editCategoryDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  _category.id = category['id'];
                  _category.name = _editCategoryName.text;
                  _category.description = _editCategoryDescription.text;
                  var result = await _categoryService.updateCategory(_category);
                  if(result > 0){
                    Navigator.pop(context);
                    getAllCategories();
                    _showSnackBar(Text('Success'));
                  }
                  print(result);
                },
                child: Text('Update'),
              )
            ],
            title: Text('Category edit form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editCategoryName,
                    decoration: InputDecoration(
                        labelText: 'Category name',
                        hintText: 'Write category name'),
                  ),
                  TextField(
                    controller: _editCategoryDescription,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: 'Category description',
                        hintText: 'Write category description'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteCategoryDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel',style: TextStyle(color: Colors.white),),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () async {
                   await _categoryService.deleteCategory(categoryId);
                },
                child: Text('Delete',style: TextStyle(color: Colors.white),),
              )
            ],
            title: Text('Are you sure you want to delete?'),

          );
        });
  }

  _editCategory(BuildContext context,categoryId) async {
    category = await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editCategoryName.text = category[0]['name'] ?? 'No name';
      _editCategoryDescription.text = category[0]['description'] ?? 'No description';
    });
    _editCategoryDialog(context);
  }

  _showSnackBar(message){
    var _snackBar = SnackBar(
        content: message
    );
    _scaffoldKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'to',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff)),
            ),
            TextSpan(
              text: 'DO',
              style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff0a500)),
            ),
          ]),
        ),
        leading: RaisedButton(
          elevation: 0,
          color: Color(0xff7579e7),
          child: Icon(
            Icons.arrow_back,
            color: Color(0xffffffff),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: IconButton(icon: Icon(Icons.edit), onPressed: () {
                  _editCategory(context, _categoryList[index].id);
                }),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _categoryList[index].name,
                    ),
                    IconButton(icon: Icon(Icons.delete), onPressed: () {
                      _deleteCategoryDialog(context, _categoryList[index].id);
                    }),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormInDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
