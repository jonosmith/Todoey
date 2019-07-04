//
//  ViewController.swift
//  Todoey
//
//  Created by Jonathan Smith on 28/6/19.
//  Copyright © 2019 Jonathan Smith. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }

    //MARK: - Tableview Datasource Methods

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
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done.toggle()

        saveItems()

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

                let newItem = Item(context: self.context)
                newItem.title = alertTextField.text!
                newItem.done = false
                
                self.itemArray.append(newItem)
                
                self.saveItems()
                
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
    
    //MARK: - Persistance
    
    func saveItems() {

        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }

    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {

        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }

        tableView.reloadData()
        
    }

}


//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        if searchBar.text!.count > 0 {
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        }
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
