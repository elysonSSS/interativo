import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
/// A simple Flutter app that displays a tourist attraction.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Visite';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        // #docregion add-widget
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ImageSection(),
              TitleSection(
                name: 'Catedral Nossa Senhora de Oliveira - Vacaria',
                location: 'Vacaria, Brasil',
              ),
              ButtonSection(),
              TextSection(
                description:
                    'A Catedral Nossa Senhora da Oliveira, que se localiza na Praça Daltro Filho,'
                    ' no centro da cidade. Projetada em 1912 por Jean-Louis Bernaz (Frei Efrem de Bellevaux),' 
                    'a Catedral possui estilo gótico, com características semelhantes à Catedral de '
                    'Notre Dame (Paris), e foi construída em pedra moura, material retirado do próprio '
                    'município e finalizada em 1933. O local abriga a pequena imagem de madeira de Nossa '
                    'Senhora da Imaculada Conceição da Oliveira, encontrada por um camponês em Vacaria por '
                    'volta de 1750, fato de grande importância para o desenvolvimento da cidade. A Catedral '
                    'foi tombada pelo município e está aberta diariamente, das 8h às 19h, com acesso na lateral '
                    'livre aos visitantes.',
              ),
              TapboxA(),
              NoteSection(),
            ],
          ),
        ),
        // #enddocregion add-widget
      ),
    );
  }
}

/// A section that displays the title and location of a tourist attraction.

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          // #docregion icon
          const FavoriteWidget(),
        ],
      ),
    );
  }
}

/// A section that displays a row of buttons.

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            color: color,
            icon: Icons.call,
            label: 'Ligar',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.near_me,
            label: 'Rota',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'Compartilhar',
          ),
        ],
      ),
    );
  }
}

/// A button with a text label.

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

/// A section that displays a block of text.

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}


/// A section that displays a carroussel of images.

class ImageSection extends StatefulWidget {
  const ImageSection({super.key});

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  int _currentPage = 0;
  final List<String> _images = [
    'images/catedral.jpg',
    'images/catedral2.jpg',
    'images/catedral3.jpg',
    'images/catedral4.jpg',
    'images/catedral5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Deslizar para a direita
          if (_currentPage < _images.length - 1) {
            setState(() {
              _currentPage++;
            });
          }
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // Deslizar para a esquerda
          if (_currentPage > 0) {
            setState(() {
              _currentPage--;
            });
          }
        }
      },
      child: Image.asset(
        _images[_currentPage],
        width: 500,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}

// #docregion favorite-widget
class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}
// #enddocregion favorite-widget

// #docregion favorite-state, favorite-state-fields, favorite-state-build
class _FavoriteWidgetState extends State<FavoriteWidget> {
  // #enddocregion favorite-state-build
  bool _isFavorited = true;
  int _favoriteCount = 41;
  // #enddocregion favorite-state-fields

  // #docregion toggle-favorite
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
  // #enddocregion toggle-favorite

  // #docregion favorite-state-build
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
  // #docregion favorite-state-fields
}

class TapboxA extends StatefulWidget {
  const TapboxA({super.key});

  @override
  State<TapboxA> createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
            _active ? Icons.check : Icons.bookmark_border,
            size: 40, // Tamanho do ícone
            color: Colors.white,

        ),
      ),
    );
  }
}

class NoteSection extends StatefulWidget {
  const NoteSection({super.key});

  @override
  NoteSectionState createState() => NoteSectionState();
}

class NoteSectionState extends State<NoteSection> {
  final _controller = TextEditingController();
  String _note = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nota',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _note = _controller.text;
              });
            },
            child: const Text('Salvar'),
          ),
          const SizedBox(height: 16),
          TextSection(description: _note),
        ],
      ),
    );
  }
}