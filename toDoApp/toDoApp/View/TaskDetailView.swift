//
//  TaskDetailView.swift
//  toDoApp
//
//  Created by Mac on 12/09/1446 AH.
//

import SwiftUICore

struct TaskDetailView: View {
    let task: Task

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(task.title)
                .font(AppFonts.title)
                .foregroundColor(AppColors.text)

            if let description = task.description {
                Text(description)
                    .font(AppFonts.body)
                    .foregroundColor(AppColors.text.opacity(0.8))
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Task Details")
        .background(AppColors.background)
    }
}
