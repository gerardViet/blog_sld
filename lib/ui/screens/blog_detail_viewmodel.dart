import 'package:blog_sld/data/models/post.dart';
import 'package:blog_sld/ui/screens/blog_detail_screen.dart';

abstract class BlogDetailRouter {}

class BlogDetailViewModel extends IBlogDetailViewModel {
  final Post _post;

  BlogDetailViewModel(this._post);

  @override
  Post get post => _post;
}
