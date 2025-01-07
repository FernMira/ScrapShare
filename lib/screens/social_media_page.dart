import 'package:flutter/material.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  int _selectedTab = 0;
  final List<Map<String, dynamic>> _feedPosts = [];
  final List<Map<String, dynamic>> _userPosts = [];
  final String _username = "User123";

  final _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scrap Share Social"),
        backgroundColor: const Color(0xFFB6D7A8), // Pastel green
      ),
      body: _buildSelectedTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Feed"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Create Post"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildSelectedTab() {
    switch (_selectedTab) {
      case 0:
        return _buildFeed();
      case 1:
        return _buildCreatePost();
      case 2:
        return _buildProfile();
      default:
        return const Center(child: Text("Error: Unknown tab"));
    }
  }

  Widget _buildFeed() {
    return ListView.builder(
      itemCount: _feedPosts.length,
      itemBuilder: (context, index) {
        final post = _feedPosts[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['username'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(post['content']),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up,
                            color: post['liked'] ? Colors.green : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              post['liked'] = !post['liked'];
                              if (post['liked']) {
                                post['likes']++;
                              } else {
                                post['likes']--;
                              }
                            });
                          },
                        ),
                        Text("${post['likes']}"),
                      ],
                    ),
                    TextButton(
                      onPressed: () => _showCommentsDialog(post),
                      child: const Text("Comments"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreatePost() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _postController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Share your recipe or leftover ideas...",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_postController.text.trim().isNotEmpty) {
                setState(() {
                  final newPost = {
                    'username': _username,
                    'content': _postController.text.trim(),
                    'likes': 0,
                    'liked': false,
                    'comments': [],
                  };
                  _feedPosts.insert(0, newPost);
                  _userPosts.insert(0, newPost);
                  _postController.clear();
                });
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB6D7A8)),
            child: const Text("Post"),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Username: $_username", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text("Your Posts:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _userPosts.length,
              itemBuilder: (context, index) {
                final post = _userPosts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(post['content']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentsDialog(Map<String, dynamic> post) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Comments"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...post['comments']
                  .map<Widget>((comment) => ListTile(title: Text(comment)))
                  .toList(),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(hintText: "Add a comment..."),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                if (commentController.text.trim().isNotEmpty) {
                  setState(() {
                    post['comments'].add(commentController.text.trim());
                  });
                  commentController.clear();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB6D7A8)),
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
