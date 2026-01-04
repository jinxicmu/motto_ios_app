//
//  mottoApp.swift
//  motto
//
//  Created by Jin Xi on 1/2/26.
//

import SwiftUI
import AppTrackingTransparency
import ZarliSDKSwift
import GoogleMobileAds

@main
struct mottoApp: App {
    @StateObject private var adManager = AdManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(adManager)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    requestTracking()
                }
        }
    }
    
    private func requestTracking() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            ATTrackingManager.requestTrackingAuthorization { status in
                // Initialize AdMob and Zarli SDKs
                GADMobileAds.sharedInstance().start(completionHandler: nil)
                
                let config = ZarliConfiguration(
                    apiKey: "zk_live_ZZAxnEi7T0_bvOVilVN6o5xKrN1j-a8AVssrBH8M9Yc",
                    isDebugMode: false
                )
                ZarliSDK.shared.initialize(configuration: config) { success in
                    print("Zarli SDK Initialized: \(success)")
                }
            }
        }
    }
}
