part of 'home_blog_page_bloc.dart';

abstract class HomeBlogPageEvent {
  const HomeBlogPageEvent();
}

class RequestPosts extends HomeBlogPageEvent {
  const RequestPosts();
}
