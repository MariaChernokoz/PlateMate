import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            MealPlannerView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Meal Planner")
                }
            
            CartViewControllerRepresentable()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Lists")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

struct CartViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CartViewController {
        return CartViewController()
    }
    
    func updateUIViewController(_ uiViewController: CartViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
