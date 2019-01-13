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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        
//        print(dataFilePath)

        loadItems()
        

        
//        if let items  = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
        
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
        //Ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
      
        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done.toggle()
//         itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
 
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
                      
    //                    self.defaults.set(self.itemArray, forKey: "TodoListArray")
                       
                        self.saveItems()
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
   
    
    //MARK - Model Manupulation Methods
    
    //TODO : add saveItems() method, encoding
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch{
            print("Error encoding item array. \(error)")
        }
        tableView.reloadData()
    }
    
    //TODO : add loadItems() method, decoding
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
                print("Error decoding item array. \(error)")
            }
        }
    }
    
    
}

