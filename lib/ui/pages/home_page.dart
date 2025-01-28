import 'package:flutter/material.dart';
import 'package:flutter_mapa/ui/pages/detail_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorTheme.surfaceContainer,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SearchBar(),
          CustomChoiceChip(),
          CustomCarrusel(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var colorTheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorTheme.surfaceContainer,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hola, Cristian',
                style: TextStyle(
                    fontSize: size.width * 0.06, fontWeight: FontWeight.bold),
              ),
              Text(
                'Explora las Ecorutas de Uninorte',
                style: TextStyle(fontSize: size.width * 0.04),
              ),
            ],
          ),
          CircleAvatar(
            radius: size.width * 0.06, // Replace with your image asset
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomCarrusel extends StatelessWidget {
  const CustomCarrusel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var colorTheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: List.generate(3, (index) {
            return Container(
              width: size.width * 0.85,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: colorTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailRoute(
                              tag: index,
                            ),
                          ),
                        ),
                        child: Hero(
                          tag: index,
                          child: Image.network(
                            'https://plus.unsplash.com/premium_photo-1700143162587-5c09d6e3eece?q=80&w=2875&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            height: size.width * 0.9,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(
                            'Especies nativas y exoticas', // Replace with the actual route name
                            style: TextStyle(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: colorTheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.star, color: Colors.orange),
                              SizedBox(width: 4),
                              Text(
                                '4.0', // Replace with the actual rating
                                style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: colorTheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: colorTheme.primary,
                          size: size.width * 0.08,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Universidad del norte', // Replace with the actual location
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: colorTheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var colorTheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      backgroundColor: colorTheme.surfaceContainer,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configuración',
        ),
      ],
      currentIndex: 0, // Set the current index
      onTap: (index) {
        // Handle item tap
      },
      selectedLabelStyle: TextStyle(
        fontSize: size.width * 0.03,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 0,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: false,
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), // Esquinas redondeadas
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search,
              color: Colors.grey), // Icono de búsqueda a la izquierda
          suffixIcon: IconButton(
            icon: Icon(Icons.filter_list,
                color: Colors.grey), // Icono de filtro a la derecha
            onPressed: () {
              // Acción del botón de filtro
              print('Abrir filtros');
            },
          ),
          border: InputBorder.none, // Quitar borde predeterminado
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}

class CustomChoiceChip extends StatefulWidget {
  const CustomChoiceChip({super.key});

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  int _selectedIndex = 0; // Índice del chip seleccionado

  final List<Map<String, dynamic>> _filters = [
    {'label': 'Más Popular', 'icon': Icons.trending_up},
    {'label': 'Recientes', 'icon': Icons.new_releases},
    {'label': 'Mejor Valorados', 'icon': Icons.star},
    {'label': 'Cerca de mí', 'icon': Icons.location_on},
  ];
  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: Row(
          children: List.generate(_filters.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      _filters[index]['icon'],
                      size: 20,
                      color: _selectedIndex == index
                          ? colorTheme.onPrimary
                          : colorTheme.primary,
                    ),
                    SizedBox(width: 6),
                    Text(_filters[index]['label'],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? colorTheme.onPrimary
                              : colorTheme.primary,
                        )),
                  ],
                ),
                selected: _selectedIndex == index,
                selectedColor:
                    colorTheme.primary, // Color cuando está seleccionado
                onSelected: (bool selected) {
                  setState(() {
                    _selectedIndex = index; // Actualizar la selección
                  });
                },
                // backgroundColor:
                //   Colors.blue[100], // Color cuando no está seleccionado
                labelStyle: TextStyle(
                  color:
                      _selectedIndex == index ? Colors.white : Colors.blue[900],
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                showCheckmark: false, // Desactivar el chulo del seleccionado
              ),
            );
          }),
        ),
      ),
    );
  }
}
