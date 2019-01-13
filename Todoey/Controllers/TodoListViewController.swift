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
    var itemArray : [Item] = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let newItem1 = Item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        let newItem2 = Item()
        newItem2.title = "Find Tom"
        itemArray.append(newItem2)
        

        
        if let items  = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
        
    }

    //MARK - TableView DataSoucre Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
//        print("CellForRowAtIndexPath Called")
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
      
        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done.toggle()
//         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.reloadData()
        
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
            
//            let item = Item()
//            item.title = textField.text!
//            self.itemArray.append(item)
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
//            self.tableView.reloadData()

            
                        if let textFieldValid = textField.text {
                if textFieldValid != "" {
                    let tempItem : Item = Item()
                    tempItem.title = textFieldValid
                    self.itemArray.append(tempItem)
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

