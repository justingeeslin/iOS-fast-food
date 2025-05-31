import Foundation
import CoreLocation

struct FastFoodItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let restaurant: String
    let price: Double
    let additiveScore: Int // 1-5 scale, 5 being completely additive-free
    let ingredients: [String]
    let allergens: [String]
    let calories: Int
    let protein: Double
    let carbs: Double
    let fat: Double
    let isVegetarian: Bool
    let isVegan: Bool
    let isGlutenFree: Bool
    
    var scoreDescription: String {
        switch additiveScore {
        case 5: return "Completely Additive-Free"
        case 4: return "Minimal Additives"
        case 3: return "Some Additives"
        case 2: return "Many Additives"
        default: return "High in Additives"
        }
    }
}

struct Restaurant: Identifiable, Codable {
    let id = UUID()
    let name: String
    let distance: Double // in miles
    let latitude: Double
    let longitude: Double
    let bestItems: [FastFoodItem]
    
    var averageScore: Int {
        let total = bestItems.reduce(0) { $0 + $1.additiveScore }
        return bestItems.isEmpty ? 0 : total / bestItems.count
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

class FastFoodDataManager: ObservableObject {
    @Published var featuredItems: [FastFoodItem] = []
    @Published var nearbyRestaurants: [Restaurant] = []
    
    init() {
        loadSampleData()
    }
    
    func refreshData() {
        // In a real app, this would fetch from an API
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadSampleData()
        }
    }
    
    private func loadSampleData() {
        // Sample featured items (highest scoring)
        featuredItems = [
            FastFoodItem(
                name: "Fresh Fruit Cup",
                restaurant: "Chick-fil-A",
                price: 3.29,
                additiveScore: 5,
                ingredients: ["Fresh strawberries", "Fresh blueberries", "Fresh apple pieces", "Fresh orange segments"],
                allergens: [],
                calories: 70,
                protein: 1.0,
                carbs: 16.0,
                fat: 0.0,
                isVegetarian: true,
                isVegan: true,
                isGlutenFree: true
            ),
            FastFoodItem(
                name: "Grilled Chicken Sandwich",
                restaurant: "Chick-fil-A",
                price: 6.59,
                additiveScore: 4,
                ingredients: ["Grilled chicken breast", "Multigrain bun", "Lettuce", "Tomato"],
                allergens: ["Gluten"],
                calories: 320,
                protein: 28.0,
                carbs: 36.0,
                fat: 5.0,
                isVegetarian: false,
                isVegan: false,
                isGlutenFree: false
            ),
            FastFoodItem(
                name: "Veggie Delite Salad",
                restaurant: "Subway",
                price: 5.99,
                additiveScore: 4,
                ingredients: ["Mixed greens", "Tomatoes", "Cucumbers", "Green peppers", "Red onions", "Olives"],
                allergens: [],
                calories: 60,
                protein: 3.0,
                carbs: 11.0,
                fat: 1.0,
                isVegetarian: true,
                isVegan: true,
                isGlutenFree: true
            )
        ]
        
        // Sample nearby restaurants
        nearbyRestaurants = [
            Restaurant(
                name: "Chick-fil-A",
                distance: 0.3,
                latitude: 37.7749,
                longitude: -122.4194,
                bestItems: [
                    FastFoodItem(
                        name: "Fresh Fruit Cup",
                        restaurant: "Chick-fil-A",
                        price: 3.29,
                        additiveScore: 5,
                        ingredients: ["Fresh strawberries", "Fresh blueberries", "Fresh apple pieces", "Fresh orange segments"],
                        allergens: [],
                        calories: 70,
                        protein: 1.0,
                        carbs: 16.0,
                        fat: 0.0,
                        isVegetarian: true,
                        isVegan: true,
                        isGlutenFree: true
                    ),
                    FastFoodItem(
                        name: "Grilled Chicken Sandwich",
                        restaurant: "Chick-fil-A",
                        price: 6.59,
                        additiveScore: 4,
                        ingredients: ["Grilled chicken breast", "Multigrain bun", "Lettuce", "Tomato"],
                        allergens: ["Gluten"],
                        calories: 320,
                        protein: 28.0,
                        carbs: 36.0,
                        fat: 5.0,
                        isVegetarian: false,
                        isVegan: false,
                        isGlutenFree: false
                    ),
                    FastFoodItem(
                        name: "Side Salad",
                        restaurant: "Chick-fil-A",
                        price: 4.39,
                        additiveScore: 4,
                        ingredients: ["Mixed greens", "Red cabbage", "Carrots", "Cherry tomatoes"],
                        allergens: [],
                        calories: 80,
                        protein: 5.0,
                        carbs: 7.0,
                        fat: 4.5,
                        isVegetarian: true,
                        isVegan: true,
                        isGlutenFree: true
                    )
                ]
            ),
            Restaurant(
                name: "Subway",
                distance: 0.5,
                latitude: 37.7849,
                longitude: -122.4094,
                bestItems: [
                    FastFoodItem(
                        name: "Veggie Delite Salad",
                        restaurant: "Subway",
                        price: 5.99,
                        additiveScore: 4,
                        ingredients: ["Mixed greens", "Tomatoes", "Cucumbers", "Green peppers", "Red onions", "Olives"],
                        allergens: [],
                        calories: 60,
                        protein: 3.0,
                        carbs: 11.0,
                        fat: 1.0,
                        isVegetarian: true,
                        isVegan: true,
                        isGlutenFree: true
                    ),
                    FastFoodItem(
                        name: "Turkey Breast Sandwich",
                        restaurant: "Subway",
                        price: 7.99,
                        additiveScore: 3,
                        ingredients: ["Turkey breast", "9-grain wheat bread", "Lettuce", "Tomatoes", "Cucumbers"],
                        allergens: ["Gluten"],
                        calories: 280,
                        protein: 18.0,
                        carbs: 46.0,
                        fat: 3.5,
                        isVegetarian: false,
                        isVegan: false,
                        isGlutenFree: false
                    ),
                    FastFoodItem(
                        name: "Apple Slices",
                        restaurant: "Subway",
                        price: 1.99,
                        additiveScore: 5,
                        ingredients: ["Fresh apple slices"],
                        allergens: [],
                        calories: 35,
                        protein: 0.0,
                        carbs: 9.0,
                        fat: 0.0,
                        isVegetarian: true,
                        isVegan: true,
                        isGlutenFree: true
                    )
                ]
            ),
            Restaurant(
                name: "Chipotle",
                distance: 0.8,
                latitude: 37.7649,
                longitude: -122.4294,
                bestItems: [
                    FastFoodItem(
                        name: "Burrito Bowl",
                        restaurant: "Chipotle",
                        price: 9.99,
                        additiveScore: 4,
                        ingredients: ["Brown rice", "Black beans", "Grilled chicken", "Fresh salsa", "Lettuce", "Guacamole"],
                        allergens: [],
                        calories: 630,
                        protein: 45.0,
                        carbs: 62.0,
                        fat: 23.0,
                        isVegetarian: false,
                        isVegan: false,
                        isGlutenFree: true
                    ),
                    FastFoodItem(
                        name: "Veggie Bowl",
                        restaurant: "Chipotle",
                        price: 8.99,
                        additiveScore: 4,
                        ingredients: ["Brown rice", "Black beans", "Fajita veggies", "Fresh salsa", "Lettuce", "Guacamole"],
                        allergens: [],
                        calories: 430,
                        protein: 16.0,
                        carbs: 65.0,
                        fat: 16.0,
                        isVegetarian: true,
                        isVegan: true,
                        isGlutenFree: true
                    ),
                    FastFoodItem(
                        name: "Chips & Guacamole",
                        restaurant: "Chipotle",
                        price: 4.99,
                        additiveScore: 3,
                        ingredients: ["Tortilla chips", "Avocados", "Lime juice", "Cilantro", "Red onion", "Jalapeño"],
                        allergens: [],
                        calories: 770,
                        protein: 12.0,
                        carbs: 73.0,
                        fat: 48.0,
                        isVegetarian: true,
                        isVegan: true,
                        isGlutenFree: true
                    )
                ]
            )
        ]
    }
}