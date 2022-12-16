//
//  TaskViewModel.swift
//  ToDoListMVVM
//
//  Created by Arailym on 17.04.2022.
//

import Foundation
import UIKit

struct State {
    enum EditingStyle {
        case addTask(String)
        case deleteTask(IndexPath)
        case toggleTask(IndexPath)
        case loadTasks([TaskItem])
        case none
    }
    
    var todolistarray: [TaskItem]
    
    var editingStyle: EditingStyle{
        didSet {
            switch editingStyle {
            case let .addTask(newTaskName):
                let newTask = TaskItem()
                newTask.taskName = newTaskName
                todolistarray.append(newTask)
                break
            case let .deleteTask(indexPath):
                todolistarray.remove(at: indexPath.row)
                break
            case let .toggleTask(indexPath):
                todolistarray[indexPath.row].istaskComplete.toggle()
                break
            case let .loadTasks(array):
                todolistarray = array
                break
            case .none:
                break
            }
        }
    }
    
    init(array: [TaskItem]) {
        todolistarray = array
        editingStyle = .none
    }
    
    func text(at indexPath: IndexPath) -> String {
        return todolistarray[indexPath.row].taskName
    }
    
    func isComplete( at indexPath: IndexPath) -> Bool {
        return todolistarray[indexPath.row].istaskComplete
    }
}

class TaskViewModel {
    var state = State(array: []){
        didSet {
            callback(state)
        }
    }
    
    let callback: (State) -> ()
    
    init(callback: @escaping (State) -> ()){
        self.callback = callback
    }
    
    func addNewTask(taskname: String){
        state.editingStyle = .addTask(taskname)
        saveTask()
    }
    
    func deleteTask(at indexPath: IndexPath){
        state.editingStyle = .deleteTask(indexPath)
        saveTask()
    }
    
    func toggleTask(at indexPath: IndexPath){
        state.editingStyle = .toggleTask(indexPath)
        saveTask()
    }
    
    func accessoryType(at indexPath: IndexPath) -> UITableViewCell.AccessoryType {
        if state.isComplete(at: indexPath){
            return .checkmark
        }
        return .none
    }
    
    func saveTask(){
        let defaults = UserDefaults.standard
        
        do{
            let encodeData = try JSONEncoder().encode(state.todolistarray)
            defaults.set(encodeData, forKey: "taskItemArray")
        } catch {
            print("unable to encode Array(\(error))")
        }
    }
    
    func loadTask(){
        let defaults = UserDefaults.standard
        
        do{
            if let data = defaults.data(forKey: "taskItemArray"){
                let array = try JSONDecoder().decode([TaskItem].self, from: data)
                state.editingStyle = .loadTasks(array)
            }
        } catch {
            print("unable to encode Array(\(error))")
        }
        
    }
}
