import SwiftUI
import CoreLocation

struct HomeView: View {
    @StateObject private var dataManager = FastFoodDataManager()
    @State private var selectedLocation = "Current Location"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Location Header
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                        Text(selectedLocation)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Featured Items Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("🌟 Top Additive-Free Picks")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(dataManager.featuredItems) { item in
                                    FeaturedItemCard(item: item)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Nearby Restaurants Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("🏪 Nearby Restaurants")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVStack(spacing: 12) {
                            ForEach(dataManager.nearbyRestaurants, id: \.name) { restaurant in
                                RestaurantCard(restaurant: restaurant)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Fast Food Finder")
            .refreshable {
                dataManager.refreshData()
            }
        }
    }
}

struct FeaturedItemCard: View {
    let item: FastFoodItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Score Badge
            HStack {
                Spacer()
                ScoreBadge(score: item.additiveScore)
            }
            
            // Item Details
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(item.restaurant)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("$\(item.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
            }
            
            Spacer()
        }
        .frame(width: 180, height: 120)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct RestaurantCard: View {
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Restaurant Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(restaurant.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.secondary)
                        Text("\(restaurant.distance, specifier: "%.1f") mi")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // Average Score
                ScoreBadge(score: restaurant.averageScore)
            }
            
            // Best Items
            Text("Best Additive-Free Options:")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            LazyVStack(spacing: 8) {
                ForEach(restaurant.bestItems.prefix(3)) { item in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.name)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Text("$\(item.price, specifier: "%.2f")")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                        
                        Spacer()
                        
                        ScoreBadge(score: item.additiveScore, size: .small)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct ScoreBadge: View {
    let score: Int
    let size: BadgeSize
    
    init(score: Int, size: BadgeSize = .normal) {
        self.score = score
        self.size = size
    }
    
    enum BadgeSize {
        case small, normal
        
        var fontSize: Font {
            switch self {
            case .small: return .caption
            case .normal: return .subheadline
            }
        }
        
        var padding: CGFloat {
            switch self {
            case .small: return 6
            case .normal: return 8
            }
        }
    }
    
    var badgeColor: Color {
        switch score {
        case 5: return .green
        case 4: return .mint
        case 3: return .yellow
        case 2: return .orange
        default: return .red
        }
    }
    
    var body: some View {
        Text("\(score)")
            .font(size.fontSize)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(minWidth: size.padding * 3)
            .padding(.horizontal, size.padding)
            .padding(.vertical, size.padding * 0.5)
            .background(badgeColor)
            .cornerRadius(size.padding)
    }
}

#Preview {
    HomeView()
}