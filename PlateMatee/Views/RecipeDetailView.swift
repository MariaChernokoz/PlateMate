import SwiftUI

struct RecipeDetailView: View {
    @State private var selectedTab = 0
    let servings = ["2 servings", "4 servings", "6 servings"]
    @State private var selectedServing = "2 servings"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Recipe image
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 250)
                
                VStack(alignment: .leading, spacing: 12) {
                    // Recipe title and metadata
                    Text("Authentic Grilled Calamari")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Mediterranean")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(15)
                        
                        Text("Gluten-Free")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(15)
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                        Text("45 minutes")
                        
                        Image(systemName: "flame")
                            .padding(.leading)
                        Text("175 cal")
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Servings picker
                Menu {
                    Picker("Servings", selection: $selectedServing) {
                        ForEach(servings, id: \.self) { serving in
                            Text(serving).tag(serving)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedServing)
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Ingredients and Instructions tabs
                Picker("Content", selection: $selectedTab) {
                    Text("Ingredients").tag(0)
                    Text("Instructions").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                if selectedTab == 0 {
                    // Ingredients list
                    VStack(alignment: .leading, spacing: 16) {
                        Button(action: {
                            // Add all to grocery list
                        }) {
                            Text("Add All To Grocery List")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        ForEach(["500g squid, cleaned", "2 tbsp olive oil", "2 cloves garlic", "1 lemon"], id: \.self) { ingredient in
                            HStack {
                                Text(ingredient)
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.gray)
                            }
                            Divider()
                        }
                    }
                    .padding(.horizontal)
                } else {
                    // Instructions list
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(1...4, id: \.self) { step in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Step \(step)")
                                    .font(.headline)
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                    .foregroundColor(.gray)
                            }
                            if step != 4 {
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarItems(trailing: Button(action: {
            // Add to favorites
        }) {
            Image(systemName: "heart")
        })
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeDetailView()
        }
    }
} 