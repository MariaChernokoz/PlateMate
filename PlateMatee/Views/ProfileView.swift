import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                // Profile header
                VStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    
                    Text("Angela Kovacs")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("angela.k@gmail.com")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                
                // Profile options
                Section {
                    NavigationLink(destination: Text("Edit Profile")) {
                        SettingsRow(icon: "person.fill", title: "Edit Profile")
                    }
                    
                    NavigationLink(destination: Text("Favourites")) {
                        SettingsRow(icon: "heart.fill", title: "Favourites")
                    }
                    
                    NavigationLink(destination: Text("Update Preferences")) {
                        SettingsRow(icon: "slider.horizontal.3", title: "Update Preferences")
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("Feedback & Support")) {
                        SettingsRow(icon: "questionmark.circle.fill", title: "Feedback & Support")
                    }
                    
                    NavigationLink(destination: Text("Settings")) {
                        SettingsRow(icon: "gearshape.fill", title: "Settings")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profile")
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.black)
                .frame(width: 24, height: 24)
            
            Text(title)
                .foregroundColor(.primary)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 