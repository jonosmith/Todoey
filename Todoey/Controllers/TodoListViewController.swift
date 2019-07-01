//
//  ViewController.swift
//  Todoey
//
//  Created by Jonathan Smith on 28/6/19.
//  Copyright © 2019 Jonathan Smith. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"

        itemArray.append(newItem)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done.toggle()
        
        tableView.reloadData()
    
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
                let newItem = Item()
                newItem.title = alertTextField.text!
                
                self.itemArray.append(newItem)
                
                self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
                
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
