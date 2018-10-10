class PageInfo {
  int pageNo = 1;
  String lastTime = 'xx';
  final int PER_PAGE = 20;

  nextPage() {
    pageNo++;
  }

  int get totalSize => PER_PAGE * pageNo;
}
