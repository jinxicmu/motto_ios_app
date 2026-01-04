import SwiftUI

struct ZenView: View {
    let motto: MottoItem
    var onFinish: () -> Void
    
    @EnvironmentObject var adManager: AdManager
    
    @State private var phase: ZenPhase = .vanish
    @State private var pulseScale: CGFloat = 1.0
    @State private var pulseOpacity: Double = 0.0
    @State private var progress: CGFloat = 0.0
    @State private var sessionTimer: Timer?
    @State private var secondsRemaining = 60
    
    enum ZenPhase {
        case vanish
        case pulse // Breathing
        case completion
    }
    
    var body: some View {
        ZStack {
            // Background - Gradient Mesh or simple soft color
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // Progress Ring
            if phase == .pulse {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.primary.opacity(0.1))
                    .frame(width: 300, height: 300)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .foregroundColor(Color.primary.opacity(0.5))
                    .frame(width: 300, height: 300)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 1.0), value: progress)
            }
            
            // Core Word
            VStack {
                Text(motto.word_cn)
                    .font(.system(size: 80, weight: .light, design: .serif))
                Text(motto.word_en.uppercased())
                    .font(.system(size: 20, weight: .medium))
                    .tracking(6)
                    .opacity(0.7)
            }
            .scaleEffect(pulseScale)
            .opacity(phase == .completion ? 0 : 1)
            
            // Breathing Guide Ring
            if phase == .pulse {
                Circle()
                    .fill(Color.primary.opacity(0.05))
                    .frame(width: 200, height: 200)
                    .scaleEffect(pulseScale * 1.5)
                    .opacity(pulseOpacity)
            }
            
            // Completion Message
            if phase == .completion {
                VStack(spacing: 20) {
                    Text("DONE")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("1 Minute of Mindfulness added to Health.")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Button(action: onFinish) {
                        Text("Return")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .background(Capsule().stroke(Color.primary, lineWidth: 1))
                    }
                    .padding(.top, 40)
                                    
                Button(action: {
                    adManager.showAd { reward in
                        if let reward = reward {
                            print("User earned reward: \(reward)")
                        }
                    }
                }) {
                    Text("I'm feeling lucky")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .underline()
                }
                .disabled(!adManager.isAdReady)
                .padding(.top, 10)
                }
                .transition(.opacity)
            }
        }
        .onAppear {
            startSession()
        }
        .onDisappear {
            sessionTimer?.invalidate()
        }
    }
    
    func startSession() {
        // Phase A: Vanish (already happened visually by entering this view, but let's smooth it)
        withAnimation(.easeIn(duration: 1.0)) {
            phase = .pulse
        }
        
        // Start Breathing Cycle
        startBreathingAnimation()
        
        // Start Session Timer
        sessionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
                progress = CGFloat(60 - secondsRemaining) / 60.0
            } else {
                finishSession()
            }
        }
    }
    
    func startBreathingAnimation() {
        // 4s In, 4s Out
        let duration = 4.0
        
        withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
            pulseScale = 1.2
            pulseOpacity = 1.0
        }
        
        // Trigger haptics loop? 
        // A simple recursive delay could work, or a Timer.
        // For simplicity, let's just let the visual guide
        // Ideally we schedule haptics every 4 seconds.
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
            // Logic to alternate haptics could go here, but syncing with animation relies on matching duration
        }
    }
    
    func finishSession() {
        sessionTimer?.invalidate()
        withAnimation {
            phase = .completion
        }
        HapticManager.shared.notification(type: .success)
        HealthKitManager.shared.saveMindfulMinutes(seconds: 60)
    }
}

struct ZenView_Previews: PreviewProvider {
    static var previews: some View {
        ZenView(motto: MottoItem(id: 1, date_index: 1, word_cn: "Zen", word_en: "Zen", sentence_cn: "", sentence_en: "", author: ""), onFinish: {})
            .environmentObject(AdManager())
    }
}
