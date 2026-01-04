import Foundation
import GoogleMobileAds
import UIKit
import SwiftUI

class AdManager: NSObject, ObservableObject, GADFullScreenContentDelegate {
    @Published var isAdReady: Bool = false
    @Published var isPresenting: Bool = false
    private var rewardedAd: GADRewardedAd?
    private var onAdComplete: ((Int?) -> Void)?
    
    // Production Ad Unit ID
    private let adUnitID = "ca-app-pub-6923673591721349/2477175787"
    
    override init() {
        super.init()
        loadAd()
    }
    
    func loadAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: adUnitID, request: request) { [weak self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                self?.isAdReady = false
                return
            }
            self?.rewardedAd = ad
            self?.rewardedAd?.fullScreenContentDelegate = self
            self?.isAdReady = true
            print("Rewarded ad loaded.")
        }
    }
    
    private var adRewarded = false
    
    func showAd(completion: @escaping (Int?) -> Void) {
        guard let ad = rewardedAd, isAdReady && !isPresenting else {
            print("Ad wasn't ready or already presenting")
            completion(nil)
            return
        }
        
        // Find root view controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let root = windowScene.windows.first?.rootViewController else {
            print("Root view controller not found")
            completion(nil)
            return
        }
        
        self.onAdComplete = completion
        self.isPresenting = true
        self.adRewarded = false
        
        ad.present(fromRootViewController: root) { [weak self] in
            let reward = ad.adReward
            print("Reward received: \(reward.amount) \(reward.type)")
            self?.adRewarded = true
            self?.onAdComplete?(Int(truncating: reward.amount))
        }
    }
    
    // MARK: - GADFullScreenContentDelegate
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad dismissed.")
        isPresenting = false
        isAdReady = false
        
        if !adRewarded {
            onAdComplete?(nil)
        }
        onAdComplete = nil
        
        loadAd()
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad failed to present: \(error.localizedDescription)")
        isPresenting = false
        isAdReady = false
        onAdComplete?(nil)
        onAdComplete = nil
        loadAd()
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        isAdReady = false
    }
}
