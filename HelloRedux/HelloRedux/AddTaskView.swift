//
//  AddTaskView.swift
//  HelloRedux
//
//  Created by Nozomu Kuwae on 2022/02/12.
//

import SwiftUI

struct AddTaskView: View {

    @State private var name: String = ""
    @EnvironmentObject var store: Store<AppState>

    struct Properties {
        let onTaskAdded: (Task) -> Void
        let tasks: [Task]
    }

    private func map(state: TaskState) -> Properties {
        Properties(
            onTaskAdded: {
                store.dispatch(action: AddTaskAction(task: $0))
            },
            tasks: state.tasks
        )
    }

    var body: some View {
        let properties = map(state: store.state.taskState)

        VStack {
            TextField("Enter task", text: $name)
                .textFieldStyle(.roundedBorder)
            Button("Add") {
                properties.onTaskAdded(Task(title: name))
            }
            List(properties.tasks, id: \.id) { task in
                Text(task.title)
            }

            Spacer()
        }.padding()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(reducer: appReducer, state: AppState())
        return AddTaskView().environmentObject(store)
    }
}
