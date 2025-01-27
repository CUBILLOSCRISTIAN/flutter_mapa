import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardInfoMain extends StatelessWidget {
  const CardInfoMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.9,
      height: context.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          _buildBackgroundImage(),
          _buildInfoOverlay(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://www.uninorte.edu.co/documents/13400067/22472752/RUTA-WEIRICK-2022.jpg/42666f93-ada3-82b1-4b05-7b6561170394?version=1.0&t=1649450088690&imageThumbnail=1',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildInfoOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const SizedBox(height: 5),
                _buildDescriptionRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Título',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDescriptionRow() {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            'Descripción de la imagen que se muestra arriba.',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: () {
            // Acción del botón
          },
          child: const Text('Botón'),
        ),
      ],
    );
  }
}
