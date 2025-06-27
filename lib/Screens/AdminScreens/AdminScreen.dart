import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gdsapplication/API/api_handler.dart';
import 'package:gdsapplication/Screens/Login/Login_screen.dart';
import 'package:gdsapplication/Models/User.dart';
import 'package:gdsapplication/Screens/AdminScreens/AddNewUser.dart';
import 'package:gdsapplication/Screens/AdminScreens/AdminDetailsScreen.dart';
import 'package:gdsapplication/Screens/settings/SettingsModel.dart';
import 'package:gdsapplication/Screens/settings/SettingsScreen.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget{
  const AdminPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AdminPageState();
  }

}

class _AdminPageState extends State<AdminPage>{
   List<User> users = []; // Define a list to store users
    @override
  void initState() {
    super.initState();
    // Fetch users from the backend API when the screen initializes
    _fetchUsers();
  }

   Future<void> _fetchUsers() async {
    try {
      // Fetch users from the backend API
      List<User> fetchedUsers = await ApiHandler().getUsers(); // Adjust this based on your API implementation

      // Update the users list in the state
      setState(() {
        users = fetchedUsers;
      });
    } catch (error) {
      // Handle errors
      print('Error fetching users: $error');
    }
  }
  void _navigateToUserDetails(User user) {
    // Navigate to the user details screen when a user is selected
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminDetailsScreen(user: user)),
    );
  }

void _deleteUser(User user) async {
    // Implement user deletion logic here, for example:
    try {
      
        await ApiHandler().deleteUser(user.Id); 
      // Remove the user from the list
      setState(() {
        users.remove(user);
      });
    } catch (error) {
      // Handle errors
      print('Error deleting user: $error');
    }
  }
  void  _showDeleteConfirmationDialog(User user){
    showDialog(context: context, builder: ( (context) =>AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteUser(user);
              },
              child: const Text('Delete'),) ])));
  }
    void _addNewUser() {
    // Implement navigation to the Add New User screen here
    // For example:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewUserScreen()), // Ensure you have this screen defined
    ).then((_) {
      _fetchUsers(); // Refresh the user list after adding a new user
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 200, 239) ,
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewUser,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Consumer<SettingsModel>(
              builder: (context, value, child) => ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  User user = users[index];
                  return Dismissible(
                    key: Key(user.Id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) => _showDeleteConfirmationDialog(user),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        user.Name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Score: ${user.Score}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        // Navigate to user details screen when user is tapped
                        _navigateToUserDetails(user);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Depression Level Chart',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PieChart(
                PieChartData(
                  sections: _createPieChartSections(),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                  borderData: FlBorderData(show: false),
                  
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _createPieChartSections() {
    final depressedUsersCount = users.where((user) => user.Score >= 5).length;
    final normalUsersCount = users.length - depressedUsersCount;

    return [
      PieChartSectionData(
        color: Colors.red,
        value: depressedUsersCount.toDouble(),
        title: '$depressedUsersCount',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.green,
        value: normalUsersCount.toDouble(),
        title: '$normalUsersCount',
        radius: 50,
      ),
    ];
  }
}