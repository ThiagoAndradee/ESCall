import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenWelcome") var hasSeenWelcome: Bool = false
    @AppStorage("hasSeenTutorial") var hasSeenTutorial: Bool = false

    var body: some View {
        VStack {
            if !hasSeenWelcome {
                WelcomeView(onNext: {
                    hasSeenWelcome = true
                })
            } else if !hasSeenTutorial {
                TutorialView(onNext: {
                    hasSeenTutorial = true
                })
            } else {
                HomeView()
            }
        }
        .onAppear {
            // Redefinir os valores temporariamente para testar novamente
            // Remova essas linhas depois de testar
            hasSeenWelcome = false
            hasSeenTutorial = false
        }
    }
}
