import SwiftUI

struct MealPlannerView: View {
    @State private var selectedDate = Date()
    @State private var selectedMealType = "Breakfast"
    let mealTypes = ["Breakfast", "Lunch", "Dinner"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Date selector
                HStack {
                    Button(action: { /* Previous week */ }) {
                        Image(systemName: "chevron.left")
                    }
                    
                    Text("This Week")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Button(action: { /* Next week */ }) {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding()
                
                // Meal type selector
                Picker("Meal Type", selection: $selectedMealType) {
                    ForEach(mealTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Weekly calendar
                List {
                    ForEach(0..<7) { day in
                        DayRow(dayName: getDayName(for: day))
                    }
                }
                
                Button(action: {
                    // Add recipe action
                }) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Meal Planner")
        }
    }
    
    private func getDayName(for offset: Int) -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .day, value: offset, to: Date()) ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}

struct DayRow: View {
    let dayName: String
    
    var body: some View {
        HStack {
            Text(dayName)
                .font(.body)
            
            Spacer()
            
            Image(systemName: "square")
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
    }
}

struct MealPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerView()
    }
} 