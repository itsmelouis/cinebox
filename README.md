# 🎬 CinéBox

**Application mobile de découverte et gestion de films et séries**

Développée avec Flutter et Supabase pour le projet de Master 2 - Développement Mobile

---

## 👥 Équipe

- **Louis** - Développeur Full Stack
- **Théo** - Développeur Full Stack

---

## 📱 Description du projet

CinéBox est une application mobile moderne permettant aux utilisateurs de :
- Découvrir des films et séries populaires via l'API TMDB
- Rechercher et filtrer du contenu par titre
- Consulter les détails complets (synopsis, note, etc.)
- Gérer une liste personnelle de favoris
- S'authentifier de manière sécurisée (Email/Password + OAuth GitHub)
- Gérer son profil et supprimer son compte

L'application met l'accent sur une **expérience utilisateur fluide** avec un design moderne inspiré de Netflix, une **architecture propre et maintenable**, et une **gestion robuste des états et erreurs**.

---

## 🏗️ Architecture

Le projet respecte strictement les principes de **Clean Architecture** et le pattern **MVVM** :

```
lib/
├── src/
│   ├── core/              # Configuration, constantes, utilitaires
│   │   ├── config/        # Configuration env, API
│   │   ├── error/         # Gestion des erreurs et exceptions
│   │   └── network/       # Client HTTP (Dio)
│   │
│   ├── features/          # Fonctionnalités par domaine
│   │   ├── auth/          # Authentification
│   │   │   ├── data/      # DataSources, Models, Repositories
│   │   │   ├── domain/    # Entities, UseCases, Repositories (interfaces)
│   │   │   └── presentation/  # Pages, Widgets, Providers, ViewModels
│   │   │
│   │   └── media/         # Films et séries
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   │
│   └── app/               # Configuration app
│       ├── router/        # Navigation (GoRouter)
│       └── widgets/       # Widgets partagés
│
└── main.dart
```

### Couches

- **Domain** : Logique métier pure (Entities, UseCases, Repository interfaces)
- **Data** : Implémentation des repositories, sources de données (API, DB)
- **Presentation** : UI, gestion d'état (Riverpod), ViewModels

---

## 🚀 Installation et lancement

### Prérequis

- **Flutter SDK** : >= 3.5.0
- **Dart SDK** : >= 3.5.0
- **Compte Supabase** (gratuit)
- **Clé API TMDB** (gratuite)

### 1. Cloner le projet

```bash
git clone https://github.com/votre-username/cinebox.git
cd cinebox
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Configuration de l'environnement

Créer un fichier `.env` à la racine du projet :

```env
# TMDB API
TMDB_API_KEY=votre_cle_api_tmdb
TMDB_BASE_URL=https://api.themoviedb.org/3
TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p

# Supabase
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_cle_anon_supabase
```

#### Obtenir les clés

**TMDB API** :
1. Créer un compte sur [themoviedb.org](https://www.themoviedb.org/)
2. Aller dans Paramètres → API
3. Demander une clé API (gratuite)

**Supabase** :
1. Créer un projet sur [supabase.com](https://supabase.com/)
2. Aller dans Settings → API
3. Copier l'URL et la clé `anon/public`

### 4. Configuration Supabase

#### a) Désactiver la confirmation d'email (pour le dev)

Dans Supabase Dashboard :
1. Authentication → Providers → Email
2. Décocher "Confirm email"
3. Sauvegarder

#### b) Créer la fonction de suppression de compte

Dans SQL Editor, exécuter :

```sql
CREATE OR REPLACE FUNCTION "deleteUser"() 
RETURNS void 
LANGUAGE SQL 
SECURITY DEFINER 
AS $$ 
  DELETE FROM auth.users WHERE id = auth.uid(); 
$$;
```

#### c) Créer la table user_media (optionnel)

```sql
CREATE TABLE IF NOT EXISTS public.user_media (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  media_id integer NOT NULL,
  media_type text NOT NULL,
  added_at timestamptz DEFAULT now(),
  UNIQUE(user_id, media_id, media_type)
);

-- Enable RLS
ALTER TABLE public.user_media ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only see their own media
CREATE POLICY "Users can view own media"
  ON public.user_media FOR SELECT
  USING (auth.uid() = user_id);

-- Policy: Users can insert their own media
CREATE POLICY "Users can insert own media"
  ON public.user_media FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Policy: Users can delete their own media
CREATE POLICY "Users can delete own media"
  ON public.user_media FOR DELETE
  USING (auth.uid() = user_id);
```

### 5. Lancer l'application

```bash
# Mode debug
flutter run

# Mode release
flutter run --release

# Choisir un device spécifique
flutter run -d <device_id>
```

---

## ✅ Fonctionnalités implémentées

### Contraintes techniques obligatoires

- ✅ **Développé en Flutter** (SDK 3.5.0+)
- ✅ **Architecture MVVM + Clean Architecture** (Domain, Data, Presentation)
- ✅ **Optimisé pour smartphones/tablets** (responsive, pas de Web)
- ✅ **Communication API REST** (TMDB API + Supabase REST API)

### Fonctionnalités avancées (3 minimum requis)

- ✅ **Authentification utilisateur** (JWT + OAuth GitHub via Supabase)
- ✅ **Cache local avec base de données** (Supabase local storage + Riverpod state management)
- ✅ **Gestion des erreurs robuste** (Try/catch, Either<Failure, Success>, messages utilisateur)
- ✅ **Navigation complexe** (GoRouter avec routes nommées, guards, bottom navigation)
- ⬜ **Mode offline avec synchronisation** (non implémenté)
- ⬜ **Internationalisation (i18n)** (non implémenté - app en français uniquement)

### Qualité du code

- ✅ **Clean Architecture stricte** (séparation Domain/Data/Presentation)
- ✅ **Analyse statique** (`flutter analyze` sans warnings critiques)
- ✅ **Gestion d'état moderne** (Riverpod avec providers typés)
- ✅ **Injection de dépendances** (Riverpod providers)

### Fonctionnalités minimales attendues

- ✅ **5 écrans avec navigation complexe**
  - Page d'accueil (découverte)
  - Page de recherche
  - Page de détails média
  - Page Ma liste
  - Page Profil
  - Page Authentification (login/signup)

- ✅ **Gestion CRUD complète** (entité "Ma liste")
  - Create : Ajouter un film/série à ma liste
  - Read : Voir ma liste de favoris
  - Update : (via ajout/suppression)
  - Delete : Retirer un film/série de ma liste

- ✅ **Recherche et filtrage**
  - Recherche par titre (films et séries)
  - Filtrage par type (films/séries)
  - Résultats en temps réel

- ✅ **Gestion des états**
  - États de chargement (CircularProgressIndicator)
  - États d'erreur (messages + retry)
  - États vides (messages informatifs)
  - États de succès (données affichées)

- ✅ **Interface responsive**
  - Adaptation portrait/paysage
  - Grid responsive (2-3 colonnes selon largeur)
  - Textes et images adaptés
  - Bottom navigation fixe

---

## 🎨 Fonctionnalités détaillées

### 🔐 Authentification

- **Inscription** : Email + mot de passe (validation complète)
- **Connexion** : Email + mot de passe
- **OAuth GitHub** : Connexion via GitHub (Supabase Auth)
- **Gestion de session** : JWT automatique via Supabase
- **Déconnexion** : Avec dialog de confirmation
- **Suppression de compte** : Avec dialog de confirmation (irréversible)
- **Protection des routes** : Pages accessibles selon l'état d'authentification

### 🎬 Découverte de contenu

- **Films populaires** : Affichage des films tendances
- **Séries populaires** : Affichage des séries tendances
- **Détails complets** :
  - Poster HD
  - Titre original et traduit
  - Synopsis
  - Note moyenne (/10)
  - Date de sortie
  - Genres
  - Bouton "Ajouter à ma liste"

### 🔍 Recherche

- **Recherche multi-type** : Films et séries simultanément
- **Recherche en temps réel** : Résultats pendant la frappe
- **Filtrage par type** : Onglets Films/Séries/Tous
- **Affichage grid** : Posters avec note
- **Gestion des états** : Loading, erreur, vide, résultats

### 📚 Ma liste

- **Liste personnelle** : Sauvegarde des favoris (nécessite authentification)
- **Ajout rapide** : Bouton sur chaque média
- **Suppression** : Retrait de la liste
- **Persistance** : Données sauvegardées dans Supabase
- **État vide** : Message si aucun favori

### 👤 Profil

- **Affichage des infos** : Email, avatar
- **Déconnexion** : Avec confirmation
- **Suppression de compte** : Avec double confirmation
- **État non authentifié** : Invitation à se connecter

---

## 🛠️ Technologies utilisées

### Framework & Langage

- **Flutter** 3.5.0+ : Framework UI cross-platform
- **Dart** 3.5.0+ : Langage de programmation

### Gestion d'état

- **Riverpod** 2.6.1 : State management moderne et typé
- **StateNotifier** : ViewModels réactifs

### Navigation

- **GoRouter** 14.6.2 : Routing déclaratif avec deep linking

### Backend & Auth

- **Supabase** 2.3.4 : Backend-as-a-Service (Auth, Database, Storage)
- **Supabase Flutter** 2.8.0 : Client Supabase pour Flutter

### API & Réseau

- **Dio** 5.7.0 : Client HTTP avec interceptors
- **Retrofit** 4.4.1 : Génération de code pour API REST
- **TMDB API** : The Movie Database (films et séries)

### Utilitaires

- **flutter_dotenv** 5.2.1 : Variables d'environnement
- **cached_network_image** 3.4.1 : Cache d'images
- **dartz** 0.10.1 : Programmation fonctionnelle (Either)
- **font_awesome_flutter** 10.8.0 : Icônes

### Dev Tools

- **build_runner** : Génération de code
- **json_serializable** : Sérialisation JSON
- **flutter_lints** : Analyse statique

---

## 📂 Structure des données

### Entities principales

**Media** (Film/Série)
```dart
class Media {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<int> genreIds;
  final MediaType mediaType;
}
```

**UserEntity** (Utilisateur)
```dart
class UserEntity {
  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;
}
```

---

## 🎯 Patterns & Principes

### Clean Architecture

- **Séparation des responsabilités** : Domain, Data, Presentation
- **Inversion de dépendances** : Interfaces dans Domain
- **Indépendance du framework** : Logique métier pure

### Design Patterns

- **Repository Pattern** : Abstraction des sources de données
- **Use Case Pattern** : Logique métier encapsulée
- **Provider Pattern** : Injection de dépendances (Riverpod)
- **MVVM** : Séparation Vue/ViewModel/Modèle
- **Either Pattern** : Gestion fonctionnelle des erreurs

### Principes SOLID

- **Single Responsibility** : Une classe = une responsabilité
- **Open/Closed** : Ouvert à l'extension, fermé à la modification
- **Liskov Substitution** : Interfaces respectées
- **Interface Segregation** : Interfaces spécifiques
- **Dependency Inversion** : Dépendances vers abstractions

---

## 🐛 Difficultés rencontrées

### 1. Configuration Supabase Email Confirmation

**Problème** : Après inscription, l'utilisateur n'était pas authentifié.

**Cause** : Supabase active par défaut la confirmation d'email.

**Solution** : Désactiver la confirmation d'email pour le développement (voir section Installation).



### 2. Suppression de compte utilisateur

**Problème** : Pas de méthode native Supabase pour qu'un utilisateur supprime son propre compte.

**Cause** : Limitation de sécurité de Supabase (seuls les admins peuvent supprimer).

**Solution** : Créer une fonction RPC SQL avec `SECURITY DEFINER` :
```sql
CREATE FUNCTION deleteUser() ... SECURITY DEFINER ...
```

---

## 🚀 Améliorations futures

- [ ] Mode offline avec synchronisation
- [ ] Internationalisation (FR/EN)
- [ ] Notifications push (nouveaux films)
- [ ] Partage de listes entre utilisateurs
- [ ] Système de recommandations personnalisées
- [ ] Filtres avancés (genre, année, note)
- [ ] Trailers vidéo intégrés
- [ ] Mode sombre/clair
- [ ] Tests unitaires et d'intégration
- [ ] CI/CD avec GitHub Actions

---

## 📄 Licence

Ce projet est développé dans un cadre académique (Master 2 - Développement Mobile).

---

**Développé avec ❤️ par Louis et Théo**
