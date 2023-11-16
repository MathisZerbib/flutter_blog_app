# Flutter Blog App

## Introduction

This Flutter project is an implementation of a simple blog app that displays a list of blog posts using the JSONPlaceholder API. The app includes various features, such as viewing posts, searching, adding/deleting posts, and viewing detailed post information along with comments.

## Features

### Displaying Posts

- The app displays a list of blog posts with animated insertions ( not implemented ) and deletions.
- Each post preview includes the author's name and the post title.

### Search Functionality

- Users can search for posts using a search bar, allowing them to filter the list based on keywords.

### CRUD Operations

- Users can add new posts to the list.
- Users can delete existing posts from the list.

### Post Details View

- Clicking on a post in the list opens a detailed view.
- The detailed view includes the post title, author's name, user profile picture, post content, an image, and a list of comments.

### Additional Features (Bonuses)

- Commenting: Users can add comments to blog posts. (0%)
- Animations: Various animations enhance the user interface. (25%)
- Page Transition Animations: Smooth animations between different screens. (10%)
- User Profiles: View and edit user profiles. (50%)
- Unit Testing: Includes unit tests for different components. (0%)

## Project Structure

The project follows a clean and organized structure with separation of concerns. Key components include:

- `libs.dart`: Centralized import file for easy access to dependencies.
- `models/`: Contains the data models for posts, comments, etc.
- `providers/`: Manages the state and data providers using Riverpod.
- `widgets/`: Reusable UI components.
- `services/`: Handles API calls and data fetching using the `Api` class.
- `pages/`: Individual screens for different sections of the app.
- `routes/`: The router made with GoRouter
- 
## Running the Project

Ensure you have Flutter and Dart installed on your machine. To run the project, use the following commands:

```bash
flutter pub get
flutter run
