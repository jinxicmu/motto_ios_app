import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()
    
    @Published var isAuthorized = false
    
    func requestAuthorization() {
        print("HealthKitManager: Checking availability...")
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKitManager: HealthKit is not available on this device.")
            return
        }
        
        let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession)!
        let typesToShare: Set = [mindfulType]
        let typesToRead: Set = [mindfulType]
        
        print("HealthKitManager: Requesting authorization...")
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            print("HealthKitManager: Authorization completion handler called.")
            if success {
                DispatchQueue.main.async {
                    self.isAuthorized = true
                }
                print("HealthKitManager: Authorization granted")
            } else {
                print("HealthKitManager: Authorization failed: \(String(describing: error))")
            }
        }
    }
    
    func saveMindfulMinutes(seconds: Double) {
        guard let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession) else { return }
        
        let startDate = Date().addingTimeInterval(-seconds)
        let endDate = Date()
        
        let mindfulSample = HKCategorySample(type: mindfulType, value: 0, start: startDate, end: endDate)
        
        healthStore.save(mindfulSample) { success, error in
            if success {
                print("Successfully saved mindful session")
            } else {
                print("Error saving mindful session: \(String(describing: error))")
            }
        }
    }
}
