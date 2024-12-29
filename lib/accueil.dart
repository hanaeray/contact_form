import 'package:flutter/material.dart';
import 'home_page.dart'; // Importation de la page HomePage

// Classe Acceuil qui représente l'écran d'accueil de l'application
class Acceuil extends StatelessWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Ajout d'un dégradé en arrière-plan
          gradient: LinearGradient(
            colors: [Color(0xFFE1BEE7), Color(0xFFCE93D8)], // Couleurs du dégradé
            begin: Alignment.topCenter, // Début du dégradé (haut)
            end: Alignment.bottomCenter, // Fin du dégradé (bas)
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Marges autour des éléments
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement les éléments
              children: [
                // Cercle contenant une icône d'utilisateur
                Container(
                  width: 200,
                  height: 200, // Dimensions du cercle
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Couleur de fond grise
                    shape: BoxShape.circle, // Forme circulaire
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.account_circle, // Icône représentant un utilisateur
                      color: Colors.black, // Couleur de l'icône
                      size: 100, // Taille de l'icône
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espacement entre les éléments

                // Texte de bienvenue
                const Text(
                  'Welcome to Connectify', // Message principal
                  style: TextStyle(
                    fontSize: 28, // Taille du texte
                    fontWeight: FontWeight.bold, // Texte en gras
                    color: Colors.black, // Couleur du texte
                  ),
                  textAlign: TextAlign.center, // Centrer le texte
                ),

                const SizedBox(height: 15), // Espacement entre les textes

                // Texte d'explication
                const Text(
                  'Easily save and manage your contacts with our user-friendly app.', // Message secondaire
                  style: TextStyle(
                    fontSize: 16, // Taille du texte
                    color: Colors.black, // Couleur du texte
                  ),
                  textAlign: TextAlign.center, // Centrer le texte
                ),

                const SizedBox(height: 50), // Grand espacement avant le bouton

                // Bouton pour accéder à la page principale
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 206, 22, 151), // Couleur de fond du bouton
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Marges internes
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                      side: const BorderSide(color: Colors.black), // Bordure noire
                    ),
                  ),
                  onPressed: () {
                    // Navigation vers HomePage lorsque le bouton est pressé
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()), // Remplace la page actuelle
                    );
                  },
                  child: const Text(
                    'Start Now', // Texte du bouton
                    style: TextStyle(
                      fontSize: 18, // Taille du texte
                      fontWeight: FontWeight.bold, // Texte en gras
                      color: Colors.black, // Couleur du texte
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
