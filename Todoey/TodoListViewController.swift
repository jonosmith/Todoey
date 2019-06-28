//
//  ViewController.swift
//  Todoey
//
//  Created by Jonathan Smith on 28/6/19.
//  Copyright © 2019 Jonathan Smith. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let addTodoItemAlert = createAddTodoItemAlert()
        
        present(addTodoItemAlert, animated: true, completion: nil)

    }
    
    func createAddTodoItemAlert() -> UIAlertController {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if (alertTextField.text != nil) {
                self.itemArray.append(alertTextField.text!)
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (addedTextField) in
            alertTextField.placeholder = "Enter a name"
            
            // Keep in scope of parent
            alertTextField = addedTextField
        }
        
        
        alert.addAction(action)
        
        return alert
    }
}
