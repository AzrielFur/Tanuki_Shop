  import 'package:flutter/material.dart';
  import 'dart:io';
  import 'package:image_picker/image_picker.dart';

  class CameraPage extends StatefulWidget {
    const CameraPage({super.key});

    @override
    State<CameraPage> createState() => _CameraPageState();
  }

  class _CameraPageState extends State<CameraPage> {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _selectedImage;
    bool _isLoading = false;

    Future<void> _pickImageFromGallery() async {
      try {
        setState(() => _isLoading = true);
        
        final XFile? image = await _imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );

        if (image != null) {
          setState(() {
            _selectedImage = image;
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No se seleccionó ninguna imagen')),
            );
          }
        }
      } catch (e) {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }

    Future<void> _pickImageFromCamera() async {
      try {
        setState(() => _isLoading = true);
        
        final XFile? image = await _imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
        );

        if (image != null) {
          setState(() {
            _selectedImage = image;
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No se capturó ninguna foto')),
            );
          }
        }
      } catch (e) {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }

    void _useImage() {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor selecciona una imagen')),
        );
        return;
      }
      
      // Retornar la ruta de la imagen al screen anterior
      Navigator.of(context).pop(_selectedImage!.path);
    }

    void _clearImage() {
      setState(() => _selectedImage = null);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Seleccionar Imagen'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFe6f7ff), Color(0xFF008fee)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Título
                const Text(
                  'Captura o Selecciona una Imagen',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                
                // Área de vista previa
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _selectedImage == null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported,
                                      size: 80,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No hay imagen seleccionada',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(_selectedImage!.path),
                                  fit: BoxFit.contain,
                                ),
                              ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Botones de acción
                Row(
                  children: [
                    // Botón Cámara
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _pickImageFromCamera,
                        icon: const Icon(Icons.camera_alt, size: 24),
                        label: const Text('Cámara'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF20b2aa),
                          disabledBackgroundColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Botón Galería
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _pickImageFromGallery,
                        icon: const Icon(Icons.photo_library, size: 24),
                        label: const Text('Galería'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF0ea5e9),
                          disabledBackgroundColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Botones Usar / Limpiar
                if (_selectedImage != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _useImage,
                          icon: const Icon(Icons.check_circle, size: 24),
                          label: const Text('Usar Imagen'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _clearImage,
                          icon: const Icon(Icons.clear, size: 24),
                          label: const Text('Limpiar'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }
  }
    