//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Andrea Yong on 28/8/23.
//

import SwiftUI

struct AddHabit: View {
    @State private var name = ""
    @State private var description = ""
    @State private var count = 0
    
    @ObservedObject var habits: Habits
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Habit")
            .toolbar {
                Button("Save") {
                    let habit = Habit(name: name, description: description, count: count)
                    habits.habits.append(habit)
                    dismiss()
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
