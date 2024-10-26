//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(Config.global.URLs.backend.absoluteString)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
