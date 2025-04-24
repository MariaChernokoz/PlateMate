import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedFilter = 0
    let filters = ["Ingredients", "Meal Type", "Cuisine", "Cook Time"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding()
                
                // Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(filters.indices, id: \.self) { index in
                            FilterButton(title: filters[index], isSelected: selectedFilter == index) {
                                selectedFilter = index
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Recipe grid
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("We Think You'll Like These")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(0..<6) { _ in
                                RecipeCard()
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("PlateMate")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("What would you like to cook today?", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.black : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(20)
        }
    }
}

struct RecipeCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(12)
            
            Text("Recipe Name")
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text("25 minutes")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 