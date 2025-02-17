import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Entrypoint of the application.
void main() {
  runApp(const MyApp());
}

/// Application itself.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Dart URL Image', home: HomePage());
  }
}

/// [Widget] displaying the home page consisting of an image the the buttons.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State of a [HomePage].
class _HomePageState extends State<HomePage> {
  String _imageUrl = '';
  bool _isMenuOpen = false;

  // JavaScript interop for fullscreen functionality
  void _toggleFullscreen() {
    // Using dart:js to call browser APIs
    final document = html.document;
    if (document.fullscreenElement == null) {
      document.documentElement?.requestFullscreen();
    } else {
      document.exitFullscreen();
    }
  }

  // Add this method to register the view factory
  void _registerViewFactory() {
    if (_imageUrl.isNotEmpty) {
      html.IFrameElement element = html.IFrameElement()
        ..src = _imageUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'contain'
        ..style.display = 'flex'
        ..style.alignItems = 'center'
        ..style.justifyContent = 'center';

      try {
        ui.platformViewRegistry.registerViewFactory(
          'image-view',
          (int viewId) => element,
        );
      } catch (e) {
        // Factory was already registered
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Register view factory before building the widget
    _registerViewFactory();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onDoubleTap: _toggleFullscreen,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _imageUrl.isNotEmpty
                            ? const HtmlElementView(
                                viewType: 'image-view',
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration:
                            const InputDecoration(hintText: 'Image URL'),
                        onChanged: (value) => _imageUrl = value,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() {}),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
            child: const Icon(Icons.add),
          ),
        ),
        if (_isMenuOpen)
          GestureDetector(
            onTap: () => setState(() => _isMenuOpen = false),
            child: Container(
              color: Colors.black54,
              child: Stack(
                children: [
                  Positioned(
                    right: 16,
                    bottom: 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _MenuButton(
                          onPressed: () {
                            _toggleFullscreen();
                            setState(() => _isMenuOpen = false);
                          },
                          label: 'Enter fullscreen',
                          icon: Icons.fullscreen,
                        ),
                        const SizedBox(height: 8),
                        _MenuButton(
                          onPressed: () {
                            _toggleFullscreen();
                            setState(() => _isMenuOpen = false);
                          },
                          label: 'Exit fullscreen',
                          icon: Icons.fullscreen_exit,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// A button used in the context menu.
class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
