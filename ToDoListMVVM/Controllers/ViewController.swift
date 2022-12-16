//
//  ViewController.swift
//  ToDoListMVVM
//
//  Created by Arailym on 16.04.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var noteTF: UITextField!
    
    var viewModel: TaskViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadTask()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTF.delegate = self
        
        viewModel = TaskViewModel { [unowned self] (state) in
            switch state.editingStyle {
                case .addTask(_):
                    noteTF.text = ""
                    break
                case .deleteTask(_):
                    break
                case .toggleTask(_):
                    break
                case .loadTasks(_):
                    break
                case .none:
                    break
            }
            
        }
    }

    @IBAction func addPressed(_ sender: Any) {
        viewModel?.addNewTask(taskname: noteTF.text!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        noteTF.resignFirstResponder()
        return true
    }

}

