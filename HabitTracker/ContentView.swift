//
//  ContentView.swift
//  HabitTracker
//
//  Created by Andrea Yong on 25/8/23.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var count: Int
}

class Habits: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits // assign to array and exit
                return
            }
        }
        habits = [] // otherwise, set habits to an empty array
    }
}

struct ContentView: View {
    @StateObject var habitList = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habitList.habits, id: \.name) { habit in
                    HStack {
                        VStack(alignment: .leading){
                            Text(habit.name)
                                .font(.headline)
                            Text(habit.description)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("Count: \(habit.count)")
                        Button("+") {
                            oneUp(habit: habit)
                        }
                    }
                }
                .onDelete(perform: removeHabit)
            }
            .navigationTitle("Habits Tracker")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddHabit) {
            AddHabit(habits: habitList)
        }
    }
    
    func oneUp(habit: Habit) {
        if let index = habitList.habits.firstIndex(where: { $0.id == habit.id }) {
            habitList.habits[index].count += 1
        }
    }
    
    func removeHabit(at offsets: IndexSet) {
        habitList.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
