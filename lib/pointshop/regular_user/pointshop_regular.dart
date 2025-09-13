import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/pointshop/regular_user/product_detail_page.dart';

class PointShopRegularPage extends StatefulWidget {
  const PointShopRegularPage({super.key});

  @override
  State<PointShopRegularPage> createState() => _PointShopRegularPageState();
}

class _PointShopRegularPageState extends State<PointShopRegularPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategoryIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = ['전체', '의류', '용품', '음식', '기타'];
  final List<Map<String, dynamic>> allProducts = [
    {'name': '태권도 도복', 'price': '45,000원', 'category': '의류'},
    {'name': '태권도 띠', 'price': '14,000원', 'category': '의류'},
    {'name': '필통', 'price': '8,000원', 'category': '용품'},
    {'name': '연필', 'price': '1,000원', 'category': '용품'},
    {'name': '샤프', 'price': '3,500원', 'category': '용품'},
    {'name': '네모스낵', 'price': '1,200원', 'category': '음식'},
    {'name': '밭두렁', 'price': '1,000원', 'category': '음식'},
    {'name': '포카리스웨트', 'price': '1,500원', 'category': '음식'},
    {'name': '컵', 'price': '6,000원', 'category': '기타'},
  ];

  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredProducts = allProducts;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    String selectedCategory = categories[_selectedCategoryIndex];

    setState(() {
      _filteredProducts = allProducts.where((product) {
        final productName = product['name'].toLowerCase();
        final productCategory = product['category'];

        // 카테고리 필터링
        final categoryMatch =
            selectedCategory == '전체' || productCategory == selectedCategory;

        // 검색어 필터링
        final queryMatch = productName.contains(query);

        return categoryMatch && queryMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '포인트 샵',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          tabs: const [
            Tab(text: '쇼핑'),
            Tab(text: '주문내역'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 쇼핑 탭
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildCategoryFilters(),
                  const SizedBox(height: 24),
                  _buildProductGrid(),
                ],
              ),
            ),
          ),
          // 주문내역 탭
          const Center(child: Text('주문내역 페이지')),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: '찾기',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: _selectedCategoryIndex == index,
              selectedColor: mainColor,
              backgroundColor: const Color(0xFFE0E0E0),
              labelStyle: TextStyle(
                color: _selectedCategoryIndex == index
                    ? Colors.white
                    : Colors.black,
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedCategoryIndex = index;
                  _filterProducts();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide.none,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.7,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: _buildProductCard(
            name: product['name'],
            price: product['price'],
          ),
        );
      },
    );
  }

  Widget _buildProductCard({required String name, required String price}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Text('(사진 첨부)', style: TextStyle(color: Colors.grey)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      color: mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
