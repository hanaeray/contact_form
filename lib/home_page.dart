import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:contact_form/contact.dart'; // Import de la classe Contact pour gérer les contacts

// Classe principale HomePage qui représente l'interface utilisateur de l'application
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Classe d'état associée à HomePage
class _HomePageState extends State<HomePage> {
  // Contrôleurs pour gérer les entrées des champs de texte
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  // Liste pour stocker les contacts
  List<Contact> contacts = List.empty(growable: true);

  // Indice du contact actuellement sélectionné pour la modification
  int selectedIndex = -1;

  // Variables pour afficher les messages de statut (succès/erreur)
  String message = '';
  Color messageColor = Colors.green;

  @override
  void initState() {
    super.initState();

    // Personnalisation de la barre de statut et de navigation
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Barre de statut transparente
      systemNavigationBarColor: Colors.purple, // Couleur de la barre de navigation
      systemNavigationBarIconBrightness: Brightness.light, // Icônes de navigation claires
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centrer le titre
        backgroundColor: Colors.purple, // Couleur de l'app bar
        title: const Text(
          'Contact List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Marges intérieures
        child: Column(
          children: [
            const SizedBox(height: 15),
            const Text(
              'Manage your contacts easily!', // Texte d'en-tête
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Champ pour entrer le nom du contact
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person), // Icône pour indiquer un nom
                hintText: 'Contact Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Champ pour entrer le numéro de contact
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number, // Clavier numérique
              maxLength: 15, // Limite du nombre de caractères
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone), // Icône pour indiquer un numéro
                hintText: 'Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Bouton pour enregistrer ou mettre à jour un contact
            ElevatedButton(
              onPressed: _saveContact,
              child: Text(selectedIndex == -1 ? 'Save' : 'Update'), // Texte dynamique
            ),
            const SizedBox(height: 15),
            // Affichage des messages d'erreur ou de succès
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: TextStyle(color: messageColor, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 20),
            // Affichage de la liste des contacts
            Expanded(
              child: contacts.isEmpty
                  ? const Center(
                      child: Text(
                        'No Contacts yet..', // Message si la liste est vide
                        style: TextStyle(fontSize: 22),
                      ),
                    )
                  : ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => _getRow(index), // Génération des lignes
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour enregistrer ou mettre à jour un contact
  void _saveContact() {
    String name = nameController.text.trim(); // Récupération du nom
    String contact = contactController.text.trim(); // Récupération du numéro

    // Validation des champs
    if (name.isEmpty) {
      setState(() {
        message = 'Please enter a contact name'; // Message d'erreur
        messageColor = Colors.red;
      });
    } else if (contact.isEmpty) {
      setState(() {
        message = 'Please enter a contact number'; // Message d'erreur
        messageColor = Colors.red;
      });
    } else if (contact.length < 10 || contact.length > 15) {
      setState(() {
        message = 'Contact Number must be between 10 and 15 digits'; // Message d'erreur
        messageColor = Colors.red;
      });
    } else {
      setState(() {
        if (selectedIndex == -1) {
          // Ajouter un nouveau contact
          contacts.add(Contact(name: name, contact: contact));
          message = '$name successfully added';
        } else {
          // Mettre à jour un contact existant
          contacts[selectedIndex].name = name;
          contacts[selectedIndex].contact = contact;
          message = '$name successfully updated';
          selectedIndex = -1; // Réinitialisation de l'indice
        }
        // Réinitialiser les champs
        nameController.clear();
        contactController.clear();
        messageColor = Colors.green;

        // Effacer le message après 2 secondes
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            message = '';
          });
        });
      });
    }
  }

  // Fonction pour générer une ligne de la liste
  Widget _getRow(int index) {
    return Card(
      elevation: 4, // Ombre pour l'effet visuel
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.deepPurple : Colors.purple, // Couleur alternée
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0], // Initiale du nom
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name, // Nom du contact
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact), // Numéro de contact
          ],
        ),
        trailing: SizedBox(
          width: 70, // Largeur pour les icônes d'édition et de suppression
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  // Charger les données dans les champs pour modification
                  nameController.text = contacts[index].name;
                  contactController.text = contacts[index].contact;
                  setState(() {
                    selectedIndex = index; // Mettre à jour l'indice
                    message = '';
                  });
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                onTap: () {
                  // Supprimer un contact
                  String deletedContactName = contacts[index].name;
                  setState(() {
                    contacts.removeAt(index); // Supprimer de la liste
                    message = '$deletedContactName successfully deleted';
                    messageColor = Colors.green;
                  });

                  // Effacer le message après 2 secondes
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      message = '';
                    });
                  });
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
