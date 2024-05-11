// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Signalement extends StatefulWidget {
  const Signalement({super.key});

  @override
  _SignalementState createState() => _SignalementState();
}

class _SignalementState extends State<Signalement> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _localizationController = TextEditingController();
  final _dropDownOptions = [
    'Fuites d\'eau',
    'Problèmes d\'assainissement',
    'Nids-de-poule',
    'Lampadaires défectueux',
    'Autres',
  ];
  String? _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildPhotoContainer(),
          const SizedBox(height: 16),
          _buildDropDown(),
          const SizedBox(height: 16),
          _buildDescriptionField(),
          const SizedBox(height: 16),
          _buildLocalizationField(),
          const SizedBox(height: 16),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Signaler',
          style: TextStyle(fontSize: 24, color: Color(0xFF14181B)),
        ),
        Text(
          'Veuillez saisir les informations requises.',
          style: TextStyle(fontSize: 14, color: Color(0xFF57636C)),
        ),
      ],
    );
  }

  Widget _buildPhotoContainer() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E3E7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo_outlined,
              color: Color(0xFF57636C),
              size: 72,
            ),
            Text(
              'Ajouter une photo',
              style: TextStyle(fontSize: 22, color: Color(0xFF14181B)),
            ),
            Text(
              'Téléchargez une image ici...',
              style: TextStyle(fontSize: 14, color: Color(0xFF57636C)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown() {
    return DropdownButtonFormField<String>(
      value: _dropDownValue,
      items: _dropDownOptions.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) => setState(() {
        _dropDownValue = value;
      }),
      decoration: InputDecoration(
        hintText: 'Types de problèmes',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFA9CF46),
            width: 2,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16, color: Color(0xFF57636C)),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        hintText: 'Description ici...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xFF75A560),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(13, 15, 0, 0),
      ),
      maxLines: 5,
      style: const TextStyle(fontSize: 16, color: Color(0xFF14181B)),
    );
  }

  Widget _buildLocalizationField() {
    return TextFormField(
      controller: _localizationController,
      decoration: const InputDecoration(
        labelText: 'Localisation',
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF75A560),
            width: 2,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16, color: Color(0xFF14181B)),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle button press
        print('Button pressed...');
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        backgroundColor: const Color(0xFFA9CF46),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text('Envoyer le signalement'),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _localizationController.dispose();
    super.dispose();
  }
}
