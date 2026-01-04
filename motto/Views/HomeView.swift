import SwiftUI

struct HomeView: View {
    let motto: MottoItem
    var onLongPress: () -> Void
    var onRefresh: () -> Void
    
    // Simple state to track press duration for visual feedback if needed
    @State private var isPressing = false
    @State private var animateHint = false
    @State private var isRefreshing = false
    
    @State private var showingSettings = false

    var body: some View {
        ZStack {
            // Background - could be dynamic later
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isRefreshing.toggle()
                        }
                        onRefresh()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.primary)
                            .opacity(0.3)
                            .font(.system(size: 20))
                            .rotationEffect(.degrees(isRefreshing ? 360 : 0))
                            .padding()
                    }
                    
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                            .opacity(0.3)
                            .font(.system(size: 20))
                            .padding()
                    }
                }
                Spacer()
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            
            VStack(spacing: 40) {
                Spacer()
                
                // Central Word Pair
                VStack(spacing: 8) {
                    Text(motto.word_cn)
                        .font(.system(size: 60, weight: .light, design: .serif))
                    
                    Text(motto.word_en.uppercased())
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .tracking(4) // Kerning
                        .opacity(0.6)
                    
                    Text("Hold to Breathe")
                        .font(.system(size: 10, weight: .light))
                        .textCase(.uppercase)
                        .tracking(2)
                        .opacity(isPressing ? 0 : 0.3)
                        .padding(.top, 10)
                }
                .scaleEffect(isPressing ? 1.1 : 1.0)
                .scaleEffect(animateHint ? 1.02 : 1.0) // Subtle breathing idle animation
                .animation(.easeInOut(duration: 0.2), value: isPressing)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: animateHint)
                .onAppear {
                    animateHint = true
                }
                .onLongPressGesture(minimumDuration: 1.0, pressing: { pressing in
                    isPressing = pressing
                }, perform: {
                    HapticManager.shared.impact(style: .medium)
                    HealthKitManager.shared.requestAuthorization()
                    onLongPress()
                })
                
                Spacer()
                
                // Sentence components
                VStack(spacing: 16) {
                    Text(motto.sentence_cn)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .multilineTextAlignment(.center)
                    
                    Text(motto.sentence_en)
                        .font(.system(size: 14, weight: .light, design: .default))
                        .multilineTextAlignment(.center)
                        .opacity(0.8)
                    
                    Text(motto.author)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(motto: MottoItem(id: 1, date_index: 1, word_cn: "恒", word_en: "Perseverance", sentence_cn: "不积跬步，无以至千里。", sentence_en: "A journey of a thousand miles begins with a single step.", author: "Laozi"), onLongPress: {}, onRefresh: {})
    }
}
