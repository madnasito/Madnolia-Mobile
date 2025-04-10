import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class MoleculeFormButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;
  final bool isLoading; // Nuevo parámetro para controlar el estado de carga

  const MoleculeFormButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = Colors.transparent,
    this.isLoading = false, // Valor por defecto es false
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 400),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: onPressed != null
              ? const BorderSide(color: Colors.blue, width: 2)
              : null,
          foregroundColor: Colors.blue,
          shadowColor: Colors.black,
          elevation: 2,
          backgroundColor: color,
          shape: const StadiumBorder(),
        ),
        onPressed: isLoading ? null : onPressed, // Deshabilitar si está cargando
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: Center(
            child: isLoading 
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Color del indicador
                  )
                : Text(
                    text,
                    style: const TextStyle(fontSize: 17, color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}