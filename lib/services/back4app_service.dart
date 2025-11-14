import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4AppService {
  /// Initialize Parse SDK
  static Future<void> initializeParse() async {
    const keyApplicationId = "38EDYHqe7mFse9ReW9iHmIlRzCDjx9VgDgbk4s8t";
    const keyClientKey = "VI0wCwUpgu9K5G23dzFgljWDRJywvnmhMm1qreY7";
    const keyParseServerUrl = "https://parseapi.back4app.com/";

    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
      debug: true,
    );
  }

  /// Login user
  static Future<ParseUser?> login(String email, String password) async {
    final user = ParseUser.createUser(email, password);
    final response = await user.login();
    if (response.success && response.result != null) {
      return response.result as ParseUser;
    }
    return null;
  }

  /// Signup user
  static Future<bool> signup(String email, String password) async {
    final user = ParseUser.createUser(email, password);
    final response = await user.signUp();
    return response.success;
  }

  /// Logout current user
  static Future<void> logout() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    await currentUser?.logout();
  }

  /// Fetch all tasks
  static Future<List<ParseObject>> fetchTasks() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Tasks'));
    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.cast<ParseObject>();
    }
    return [];
  }

  /// Add a new task
  static Future<bool> addTask(String title, String description) async {
    final task = ParseObject('Tasks')
      ..set('title', title)
      ..set('description', description);
    final response = await task.save();
    return response.success;
  }

  /// Update an existing task
  static Future<bool> updateTask(
      String id, String title, String description) async {
    final task = ParseObject('Tasks')
      ..objectId = id
      ..set('title', title)
      ..set('description', description);
    final response = await task.save();
    return response.success;
  }

  /// Delete a task
  static Future<bool> deleteTask(String id) async {
    final task = ParseObject('Tasks')..objectId = id;
    final response = await task.delete();
    return response.success;
  }
}
