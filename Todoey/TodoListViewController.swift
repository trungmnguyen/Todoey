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
    let itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgoy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    
    
    
}

