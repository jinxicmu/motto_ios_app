import Foundation

class DataService {
    static let shared = DataService()
    
    private var allMottos: [MottoItem] = []
    
    init() {
        loadData()
    }
    
    private func loadData() {
        guard let url = Bundle.main.url(forResource: "MottoData", withExtension: "json") else {
            print("MottoData.json not found in bundle")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            allMottos = try decoder.decode([MottoItem].self, from: data)
            print("Successfully loaded \(allMottos.count) mottos")
        } catch {
            print("Error decoding MottoData: \(error)")
        }
    }
    
    func getDailyMotto() -> MottoItem? {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        
        // Use modulo to cycle through mottos if we have fewer than 365
        if allMottos.isEmpty { return nil }
        
        // Adjust for 0-based index. 
        // If dayOfYear is 1, we want index 0. 
        // If we have 3 items, day 1 -> index 0, day 2 -> index 1, day 3 -> index 2, day 4 -> index 0
        let index = (dayOfYear - 1) % allMottos.count
        
        return allMottos[index]
    }
    
    // Helper for debugging or specific date
    func getMotto(for date: Date) -> MottoItem? {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 1
        if allMottos.isEmpty { return nil }
        let index = (dayOfYear - 1) % allMottos.count
        return allMottos[index]
    }
    
    func getRandomMotto() -> MottoItem? {
        return allMottos.randomElement()
    }
}
