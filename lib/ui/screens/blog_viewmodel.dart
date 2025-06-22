import 'dart:convert';
import 'package:blog_sld/data/models/post.dart';
import 'package:blog_sld/ui/screens/blog_detail_viewmodel.dart';
import 'package:blog_sld/ui/screens/blog_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'blog_detail_screen.dart'; // Ce fichier doit exister

class BlogViewModel extends IBlogViewModel {
  BlogViewModel();

  @override
  Future<List<Post>> loadData() async {
    const callbackUrl = "https://slenderline.com/API/getBlogPost.php";
    final response = await http.get(Uri.parse(callbackUrl));
    if (response.statusCode == 200) {
      final List jsonPostsList = jsonDecode(response.body);
      return jsonPostsList
          .map((postJsonMap) => Post.fromJson(postJsonMap))
          .toList();
    } else {
      throw Exception("Erreur de chargement des données");
    }
  }

  @override
  void goToBlogDetail(BuildContext context, Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BlogDetailScreen(
              BlogDetailViewModel(post), // ← viewModel positionnel
              post: post, // ← post nommé
            ),
      ),
    );
  }
}
