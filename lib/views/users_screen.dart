import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../utils/custom_input.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isUploading = false;

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> fetchUsers() async {
    final res = await UserController.getUsers(context);
    setState(() {
      users = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All users'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchUsers,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl ?? ""),
                radius: 25,
              ),
              title: Text("${user.firstName} ${user.lastName}"),
              subtitle: Text(user.email),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            context: context,
            builder: (context) {
              return SizedBox(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Add user",
                              style: TextStyle(fontSize: 22),
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            CustomInput(
                              controller: firstNameController,
                              hintText: "First name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'First name is required';
                                }
                                return null;
                              },
                            ),
                            CustomInput(
                              controller: lastNameController,
                              hintText: "Last name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Last name is required';
                                }
                                return null;
                              },
                            ),
                            CustomInput(
                              controller: emailController,
                              hintText: "Email",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                } //Email validation regex or package
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MaterialButton(
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isUploading = true;
                                  });
                                  final newUser = User(
                                    firstName: firstNameController.text.trim(),
                                    lastName: lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                  );
                                  await UserController.addUser(
                                      context, newUser);
                                  setState(() {
                                    isUploading = false;
                                  });
                                }
                              },
                              child: Stack(
                                children: <Widget>[
                                  Visibility(
                                    visible: !isUploading,
                                    child: const Text(
                                      'Add User',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Visibility(
                                    visible: isUploading,
                                    child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
