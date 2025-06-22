import 'package:blog_sld/data/models/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class IBlogViewModel extends ChangeNotifier {
  Future<List<Post>> loadData();
  void goToBlogDetail(BuildContext context, Post post);
}

class BlogScreen extends StatefulWidget {
  final IBlogViewModel viewModel;
  const BlogScreen(this.viewModel, {Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState(viewModel);
}

class _BlogScreenState extends State<BlogScreen> {
  final IBlogViewModel viewModel;

  _BlogScreenState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Info Blog")),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: viewModel.loadData(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, postIndex) {
                  final post = snapshot.data![postIndex];
                  return InkWell(
                    onTap: (() {
                      viewModel.goToBlogDetail(context, post);
                    }),
                    child: Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    10,
                                    10,
                                    10,
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  height: 120,
                                  child: Text(
                                    "${post.title} \n\n${post.postText} ",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  "https://slenderline.com/ressources/pics/articles_blog/${post.picPath}",
                                  fit: BoxFit.cover,
                                  height: 130.0,
                                  width: 130.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 30,
                            // color: Colors.white,
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Date: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(post.creationTimestamp * 1000))}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "  -  nombre de vues ${post.numberOfReadings} ",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text("erreur de chargement");
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}
