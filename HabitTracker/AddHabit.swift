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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let habit = Habit(name: name, description: description, count: count)
                        habits.habits.append(habit)
                        dismiss()
                    }.disabled(isValidHabit == false)
                }
            }
        }
    }
    
    var isValidHabit: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || description.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
