//
//  TaskViewModel.swift
//  toDoApp
//
//  Created by Mac on 12/09/1446 AH.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var newTask: String = ""
    @AppStorage("isDarkMode") var isDarkMode: Bool = false 

    // Sort tasks so completed ones appear at the bottom
    var sortedTasks: [Task] {
        tasks.sorted { !$0.isCompleted && $1.isCompleted }
    }

    // Function to add a new task
    func addTask() {
        if !newTask.isEmpty {
            withAnimation(.easeIn(duration: 0.3)) {
                tasks.append(Task(title: newTask, isCompleted: false))
            }
            newTask = "" // Clear input field after adding
        }
    }

    // Function to toggle task completion status
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    // Function to delete tasks
    func deleteTask(at offsets: IndexSet) {
        withAnimation(.easeOut(duration: 0.3)) {
            tasks.remove(atOffsets: offsets)
        }
    }
}
