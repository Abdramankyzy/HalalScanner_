import Foundation

enum HalalStatus {
    case halal
    case haram
    case doubtful
}

struct Product {

    let name: String
    let emoji: String
    let halalStatus: HalalStatus
    let category: String
    let calories: Int
    let haramItem: String?

    init(name: String, emoji: String, halalStatus: HalalStatus, category: String, calories: Int, haramItem: String? = nil) {
        self.name  = name
        self.emoji   = emoji
        self.halalStatus = halalStatus
        self.category  = category
        self.calories  = calories
        self.haramItem = haramItem
    }

    var isHalal: Bool {
        return halalStatus == .halal
    }
    
 
   
}


struct ProductCatalog {

    static let products: [String: Product] = [

        "rollton": Product(
            name: "Rollton Instant Noodles",
            emoji: "🍜",
            halalStatus: .halal,
            category: "Fast Food",
            calories: 450
        ),

        "dizzy": Product(
            name: "Dizzy",
            emoji: "🥤",
            halalStatus: .halal,
            category: "Beverages",
            calories: 50
        ),

        "bal qymyz": Product(
            name: "Honey Kumis",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "chudo": Product(
            name: "Chudo Milkshake",
            emoji: "🥤",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "danone packet": Product(
            name: "Danone Yogurt (Live Culture)",
            emoji: "🍶",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "prost syrok": Product(
            name: "Prostokvashino Cheese Bar",
            emoji: "🍬",
            halalStatus: .haram,
            category: "Dairy Products",
            calories: 365
        ),

        "krest": Product(
            name: "Krestyanskoye Butter 72.5%",
            emoji: "🧈",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "shino": Product(
            name: "Shin-Line Butter 72.5%",
            emoji: "🧈",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "volo": Product(
            name: "Vologda Butter 82.5%",
            emoji: "🧈",
            halalStatus: .haram,
            category: "Dairy Products",
            calories: 365
        ),

        "zhailau": Product(
            name: "Zhailau Butter 72.5%",
            emoji: "🧈",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "zhailau kaimak": Product(
            name: "Zhailau Sour Cream",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "xox": Product(
            name: "Khokhlushka Sour Cream 20%",
            emoji: "🥛",
            halalStatus: .haram,
            category: "Dairy Products",
            calories: 365
        ),

        "sme": Product(
            name: "Umut Sour Cream 20%",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "president kaimak": Product(
            name: "President Sour Cream 20%",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "prost kaimak": Product(
            name: "Prostokvashino Sour Cream",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "zhel sgu": Product(
            name: "3 Wishes Condensed Milk",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "burenka": Product(
            name: "Burenka Condensed Milk",
            emoji: "🥛",
            halalStatus: .doubtful,
            category: "Dairy Products",
            calories: 365
        ),

        "derevenskoe": Product(
            name: "Village Milk",
            emoji: "🥛",
            halalStatus: .doubtful,
            category: "Dairy Products",
            calories: 365
        ),

        "miloko": Product(
            name: "Miloko Milk",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "shadr": Product(
            name: "Shadrinsk Milk",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "aya moloko": Product(
            name: "Aya Milk",
            emoji: "🥛",
            halalStatus: .doubtful,
            category: "Dairy Products",
            calories: 365
        ),

        "petr kefir": Product(
            name: "Petropavlovsk Kefir",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "petr moloko": Product(
            name: "Petropavlovsk Milk",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "natige": Product(
            name: "Natige Yogurt",
            emoji: "🍶",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "rastishka": Product(
            name: "Rastishka Yogurt",
            emoji: "🍶",
            halalStatus: .haram,
            category: "Dairy Products",
            calories: 365
        ),

        "tan": Product(
            name: "Tan Drink",
            emoji: "🥛",
            halalStatus: .halal,
            category: "Dairy Products",
            calories: 365
        ),

        "snickers": Product(
            name: "Snickers",
            emoji: "🍫",
            halalStatus: .halal,
            category: "Sweets",
            calories: 365
        ),

        "chocopie": Product(
            name: "Choco Pie",
            emoji: "🍫",
            halalStatus: .haram,
            category: "Sweets",
            calories: 365,
            haramItem: "sorbitan tristearate, gelatin, e319"
        ),

        "grizzly": Product(
            name: "Grizzly Chips",
            emoji: "🥨",
            halalStatus: .halal,
            category: "Snacks",
            calories: 365
        ),

        "doritos": Product(
            name: "Doritos Chips",
            emoji: "🥨",
            halalStatus: .doubtful,
            category: "Snacks",
            calories: 365,
            haramItem: "sodium inosinate"
        ),

        "lays": Product(
            name: "Lays Chips",
            emoji: "🥨",
            halalStatus: .doubtful,
            category: "Snacks",
            calories: 365,
            haramItem: "crustacean additives"
        ),
    ]
}
