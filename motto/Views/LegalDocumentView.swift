import SwiftUI

struct LegalDocumentView: View {
    let title: String
    let content: String
    
    var body: some View {
        ScrollView {
            Text(content)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LegalDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LegalDocumentView(title: "Terms of Service", content: "This is the placeholder text for Terms of Service.")
        }
    }
}
