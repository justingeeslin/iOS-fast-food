import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.green)
    }
}

struct SearchView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Search for restaurants and food items")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Search")
        }
    }
}

struct FavoritesView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your favorite additive-free options")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Favorites")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Manage your preferences and settings")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ContentView()
}