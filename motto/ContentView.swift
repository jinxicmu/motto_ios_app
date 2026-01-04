import SwiftUI

struct ContentView: View {
    @State private var showingZenMode = false
    @State private var dailyMotto: MottoItem?
    
    var body: some View {
        ZStack {
            if let motto = dailyMotto {
                if showingZenMode {
                    ZenView(motto: motto, onFinish: {
                        withAnimation {
                            showingZenMode = false
                        }
                    })
                    .transition(.opacity)
                } else {
                    HomeView(motto: motto, onLongPress: {
                        withAnimation {
                            showingZenMode = true
                        }
                    }, onRefresh: {
                        // Refresh with random
                        if let random = DataService.shared.getRandomMotto() {
                            withAnimation {
                                dailyMotto = random
                            }
                        }
                    })
                    .transition(.opacity)
                }
            } else {
                // Loading / Fallback state
                VStack {
                    ProgressView()
                    Text("Loading Motto...")
                }
            }
        }
        .onAppear {
            dailyMotto = DataService.shared.getDailyMotto()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
