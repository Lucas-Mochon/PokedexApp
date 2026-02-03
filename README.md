# Pokédex SwiftUI

Une application iOS développée avec **SwiftUI** qui affiche la liste et les détails des Pokémon en utilisant la **PokeAPI**.  
Le projet est construit de manière modulaire avec MVVM et supporte la pagination, le chargement des images et la recherche par nom.

---

## 🚀 Fonctionnalités

- Affichage d’une **liste paginée** de Pokémon.
- Affichage des **détails** d’un Pokémon (image, types, statistiques, hauteur, poids).
- **Recherche par nom** avec gestion des erreurs si Pokémon introuvable.
- **Chargement asynchrone** via Swift Concurrency (`async/await`).
- Gestion des états : chargement, erreur, liste vide.
- Navigation **iPad / iPhone** avec `NavigationSplitView`.
- Design inspiré des applications modernes avec `LazyVGrid` et cartes.

---

## 🧩 Architecture

Le projet est structuré selon le pattern **MVVM** :

### Models

- **PokemonListItem** : représente un Pokémon dans la liste (nom + URL).
- **Pokemon** : représente un Pokémon détaillé (id, nom, types, sprites, stats, hauteur, poids).
- **PokemonSprites** et **PokemonTypeEntry** : structures pour les détails du Pokémon.

### ViewModels

- **PokemonListViewModel** : gère la liste des Pokémon, la pagination et la recherche.
- **PokemonDetailViewModel** : gère le chargement et l’état d’un Pokémon détaillé.

### Views

- **PokemonListView** : affiche la liste paginée de Pokémon, intègre la recherche et le chargement des images.
- **PokemonDetailView** : affiche les détails d’un Pokémon sélectionné.
- **StatCard / TypeBadge / PokemonCard / PokemonImageView** : composants réutilisables pour le design.

### Services

- **PokeAPIService** : singleton qui effectue les requêtes HTTP vers la PokeAPI et décode les réponses JSON.
- **PokeEndpoint** : énumération des endpoints de l’API (`pokemonList`, `pokemonById`, `pokemonByName`).

---

## 🌐 Flux de données

1. L’utilisateur lance l’application et la liste initiale est chargée (`loadInitialPokemon()`).
2. Le scroll déclenche le chargement paginé (`loadMorePokemon()`).
3. L’utilisateur peut effectuer une recherche par nom, la liste est filtrée avec `searchPokemon()`.
4. La sélection d’un Pokémon affiche ses détails via `PokemonDetailView` et `PokemonDetailViewModel`.
5. Les images des Pokémon sont chargées de manière asynchrone et mises en cache localement dans la session.

---

## ⚙️ Technologies et outils

- Swift 5+ / SwiftUI
- Combine
- iOS 16+ (pour NavigationSplitView)
- API PokeAPI : [https://pokeapi.co/](https://pokeapi.co/)
