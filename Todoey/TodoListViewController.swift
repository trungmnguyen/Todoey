//
//  ViewController.swift
//  Todoey
//
//  Created by TRUNG NGUYEN on 1/11/19.
//  Copyright © 2019 TRUNG NGUYEN. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    // Declare the global variables/constant
    var itemArray : [String] = [String]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items  = defaults.array(forKey: "TodoListArray") as? [String]{
            itemArray = items
        }
    }

    //MARK - TableView DataSoucre Methods
    
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
//        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
            
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
//            print("Add a item pressed")
//            print(textField.text)
//            self.itemArray.append(textField.text!)
            if let textFieldValid = textField.text {
                if textFieldValid != "" {
                    self.itemArray.append(textFieldValid)
                    self.defaults.set(self.itemArray, forKey: "TodoListArray")
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
//            print("Alert Now")
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

