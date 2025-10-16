# 🚀 CinéBox - Quick Start Guide

## ✅ Ce qui est fait

**Backend 100% fonctionnel :**
- ✅ Authentification JWT + OAuth GitHub
- ✅ API CRUD Supabase avec cache TMDB
- ✅ Guards de navigation
- ✅ Plateformes de streaming
- ✅ Clean Architecture + MVVM

## 📦 Installation (3 étapes)

### 1. Installer les dépendances
```bash
flutter pub get
```

### 2. Configurer `.env`
Copier `.env.example` vers `.env` et remplir :
```env
TMDB_API_KEY=votre_clé_tmdb
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_anon_key
GITHUB_CLIENT_ID=votre_github_client_id
GITHUB_CLIENT_SECRET=votre_github_client_secret
```

### 3. Générer le code
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🗄️ Setup Supabase

1. Créer un projet sur [supabase.com](https://supabase.com)
2. Aller dans **SQL Editor**
3. Copier-coller le contenu de `supabase/schema.sql`
4. Exécuter le script

## 🔑 Setup OAuth GitHub

**Dans GitHub :**
1. Settings > Developer settings > OAuth Apps > New OAuth App
2. Remplir :
   - Homepage URL : `https://votre-projet.supabase.co`
   - Callback URL : `https://votre-projet.supabase.co/auth/v1/callback`
3. Noter Client ID et Secret

**Dans Supabase :**
1. Authentication > Providers > GitHub
2. Activer et entrer Client ID + Secret

## 🎬 Lancer l'app

```bash
flutter run
```

## 📚 Documentation

- **IMPLEMENTATION_SUMMARY.md** - Résumé complet
- **BACKEND_SETUP.md** - Guide détaillé
- **FRONTEND_GUIDE.md** - Guide pour votre collègue
- **README_FINAL.md** - Vue d'ensemble

## ⚠️ Notes importantes

### Erreurs normales

Les erreurs de type "Target of URI doesn't exist" sont **normales** avant de lancer `build_runner`.

### OAuth GitHub pour mobile

Pour une app mobile Flutter, utilisez l'URL de votre projet Supabase (pas localhost).
Supabase gère le redirect OAuth pour vous.

### Plateformes de streaming

L'API TMDB fournit les plateformes de streaming disponibles par pays.
C'est déjà implémenté dans `Media.streamingProviders`.

## 🎯 Ce qui reste à faire

Votre collègue doit créer les pages UI :
1. DiscoverPage
2. SearchPage
3. MediaDetailPage
4. MyListPage
5. ProfilePage

**Tout le backend est prêt !** Voir `FRONTEND_GUIDE.md` pour les exemples de code.

## 🆘 Support

En cas de problème :
1. Vérifier que `.env` est bien configuré
2. Vérifier que le schéma Supabase est exécuté
3. Vérifier que `build_runner` a bien généré le code
4. Lire `BACKEND_SETUP.md` pour plus de détails

---

**Projet prêt à l'emploi ! 🎉**
