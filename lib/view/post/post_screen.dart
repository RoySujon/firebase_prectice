import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:firebase_demo/view/post/add_post.dart';
import 'package:firebase_demo/view/post/update_post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/view/auth/login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _serchController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('DataTable');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Post Screen'),
        actions: [
          TextButton(
              onPressed: () {
                ref.remove();
              },
              child: Text('Clear All')),
          IconButton(
              onPressed: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    )));
              },
              icon: Icon(Icons.login_outlined)),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomeTextField(
            borderColor: Colors.blueGrey,
            controller: _serchController,
            errorText: '',
            hintText: 'Search',
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: FirebaseAnimatedList(
            query: ref.orderByChild('name'),
            itemBuilder: (context, snapshot, animation, index) {
              var name = snapshot.child('name').value.toString();
              var phone = snapshot.child('phone').value.toString();

              ref.orderByPriority();
              if (_serchController.text.trim().isEmpty) {
                //Shorting Assending
                // final List<String> abc = ['dadad', 'ajkhawe', 'kfWAK', 'dwikd'];
                // abc.sort((a, b) => a.compareTo(b));
                // print(abc);
                return Card(
                  child: ListTile(
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            onTap: () => ref
                                .child(snapshot.child('id').value.toString())
                                .remove(),
                            child: ListTile(
                              title: Text('Delete'),
                              leading: Icon(Icons.delete),
                            )),
                        PopupMenuItem(
                            onTap: () {
                              showBottomSheet(
                                context: context,
                                builder: (context) => UpdatePost(
                                  text: snapshot.child('name').value.toString(),
                                  id: snapshot.child('id').value.toString(),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text('Edit'),
                              leading: Icon(Icons.edit),
                            )),
                      ],
                    ),
                    title: Text(snapshot.child('name').value.toString()),
                    subtitle: Text(snapshot.child('phone').value == null
                        ? ''
                        : snapshot.child('phone').value.toString()),
                  ),
                );
              } else if (name.toLowerCase().toString().contains(
                      _serchController.text.toLowerCase().toString()) ||
                  phone.toLowerCase().toString().contains(
                      _serchController.text.toLowerCase().toString())) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        trailing: IconButton(
                            onPressed: () => ref
                                .child(snapshot.child('id').value.toString())
                                .remove(),
                            icon: Icon(Icons.delete)),
                        title: Text(snapshot.child('name').value.toString()),
                        subtitle:
                            Text(snapshot.child('phone').value.toString()),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddPost(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/*  Expanded(
            child: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map =
                  snapshot.data!.snapshot.value as dynamic ?? {};
              List<dynamic> message = map.values.toList();
              return ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(message[index]['name']),
                    subtitle: Text(message[index]['id']),
                  ),
                ),
                itemCount: message.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          stream: ref.onValue,
        )),
 */
