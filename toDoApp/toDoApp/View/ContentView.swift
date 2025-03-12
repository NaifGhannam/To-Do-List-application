import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                taskInputSection()
                taskListView()
            }
            .navigationTitle("To-Do List")
            .navigationDestination(for: Task.self) { task in
                TaskDetailView(task: task)
            }
            .toolbar { darkModeToggle() }
        }
        .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        .background(AppColors.background)
    }

    private func taskInputSection() -> some View {
        HStack {
            TextField("Enter new task", text: $viewModel.newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: viewModel.addTask) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(AppColors.primary)
            }
            .padding()
            .disabled(viewModel.newTask.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }

    @ViewBuilder
    private func taskListView() -> some View {
        List {
            ForEach(viewModel.sortedTasks) { task in
                NavigationLink(value: task) {
                    taskRowView(task)
                }
            }
            .onDelete(perform: viewModel.deleteTask)
            .transition(.opacity)
        }
        .listStyle(InsetGroupedListStyle())
    }

    @ViewBuilder
    private func taskRowView(_ task: Task) -> some View {
        HStack {
            Button(action: { viewModel.toggleTaskCompletion(task) }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())

            Text(task.title)
                .strikethrough(task.isCompleted, color: .gray)
                .foregroundColor(task.isCompleted ? .gray : AppColors.text)
                .font(AppFonts.body)
        }
    }

    private func darkModeToggle() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { viewModel.isDarkMode.toggle() }) {
                Image(systemName: viewModel.isDarkMode ? "moon.fill" : "sun.max.fill")
                    .foregroundColor(viewModel.isDarkMode ? .yellow : .blue)
            }
        }
    }
}
