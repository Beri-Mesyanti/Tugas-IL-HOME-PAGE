import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductCatalogPage(),
    );
  }
}

class AppleProduct {
  final String name;
  final String origin;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;

  const AppleProduct({
    required this.name,
    required this.origin,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
  });
}

const List<String> categories = [
  'All',
  'Red',
  'Green',
  'Yellow',
  'Exotic',
];

const List<AppleProduct> products = [
  AppleProduct(
    name: 'Fuji Apple',
    origin: 'Japan',
    price: 35000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/c/c1/Fuji_apple.jpg',
    rating: 4.8,
    category: 'Red',
  ),
  AppleProduct(
    name: 'Granny Smith',
    origin: 'Australia',
    price: 28000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Granny_Smith_Apple_02.JPG',
    rating: 4.5,
    category: 'Green',
  ),
  AppleProduct(
    name: 'Honeycrisp',
    origin: 'USA',
    price: 45000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/07/Honeycrisp-Apple.jpg',
    rating: 4.9,
    category: 'Red',
  ),
  AppleProduct(
    name: 'Golden Delicious',
    origin: 'USA',
    price: 30000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/0f/Golden_Delicious_apples.jpg',
    rating: 4.3,
    category: 'Yellow',
  ),
  AppleProduct(
    name: 'Pink Lady',
    origin: 'Australia',
    price: 42000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/54/Pink_Lady_apples.JPG',
    rating: 4.7,
    category: 'Red',
  ),
  AppleProduct(
    name: 'Malus Sieversii',
    origin: 'Kazakhstan',
    price: 75000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/69/Malus_sieversii_Tarbagatai.jpg',
    rating: 4.6,
    category: 'Exotic',
  ),
  AppleProduct(
    name: 'Gala Apple',
    origin: 'New Zealand',
    price: 32000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/e9/A_Gala_Apple.jpg',
    rating: 4.4,
    category: 'Red',
  ),
  AppleProduct(
    name: 'Granny Smith Mini',
    origin: 'Australia',
    price: 22000,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Granny_Smith_Apple_02.JPG',
    rating: 4.2,
    category: 'Green',
  ),
];

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AppleProduct> get _filteredProducts {
    return products.where((p) {
      final matchesCategory = _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.origin.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3EE),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryList(),
            _buildSectionTitle(),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TokoApel 🍎',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Fresh apples, delivered to you',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFD64C3F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _searchQuery = value),
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Search apples...',
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close, color: Colors.grey[400], size: 18),
                    onPressed: () => setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    }),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFD64C3F) : Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Products',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          Text(
            '${_filteredProducts.length} items',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: (_filteredProducts.length / 2).ceil(),
      itemBuilder: (context, rowIndex) {
        final leftIndex = rowIndex * 2;
        final rightIndex = leftIndex + 1;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Expanded(child: _buildProductCard(_filteredProducts[leftIndex])),
              const SizedBox(width: 14),
              if (rightIndex < _filteredProducts.length)
                Expanded(child: _buildProductCard(_filteredProducts[rightIndex]))
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductCard(AppleProduct product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              product.imageUrl,
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 130,
                  color: const Color(0xFFF0EAE4),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFD64C3F),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 130,
                color: const Color(0xFFF0EAE4),
                child: const Center(
                  child: Text('🍎', style: TextStyle(fontSize: 48)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF2D2D2D),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 11, color: Colors.grey[400]),
                    const SizedBox(width: 2),
                    Text(
                      product.origin,
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFFD64C3F),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: Color(0xFFFFC107)),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD64C3F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Add to Cart', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
