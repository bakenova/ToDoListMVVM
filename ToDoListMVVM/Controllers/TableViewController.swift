//
//  TableViewController.swift
//  ToDoListMVVM
//
//  Created by Arailym on 16.04.2022.
//

import UIKit

class TableViewController: UITableViewController {
    var viewModel: TaskViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TaskViewModel { [unowned self] (state) in
            switch state.editingStyle {
                case .addTask(_):
                    self.tableView.reloadData()
                    break
                case .deleteTask(_):
                    break
                case .toggleTask(_):
                    self.tableView.reloadData()
                    break
                case .loadTasks(_):
                    self.tableView.reloadData()
                    break
                case .none:
                    self.tableView.reloadData()
                    break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.loadTask()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.state.todolistarray.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "listCell")
        cell.textLabel?.text = viewModel?.state.text(at: indexPath)
        
        cell.accessoryType = (viewModel?.accessoryType(at: indexPath))!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.toggleTask(at: indexPath)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel?.deleteTask(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
