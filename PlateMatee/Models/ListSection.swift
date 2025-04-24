import Foundation

struct ListSection: Identifiable {
    let id = UUID()
    let title: String
    var items: [String]
    
    init(title: String, items: [String] = []) {
        self.title = title
        self.items = items
    }
} 