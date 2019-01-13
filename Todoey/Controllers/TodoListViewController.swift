//
//  ViewController.swift
//  Todoey
//
//  Created by TRUNG NGUYEN on 1/11/19.
//  Copyright © 2019 TRUNG NGUYEN. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{

   
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Declare the global variables/constant
    var itemArray : [Item] = [Item]()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(dataFilePath)
        //Declare searchBar delegate
       searchBar.delegate = self

    }

//MARK: - TableView DataSoucre Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        //Ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done.toggle()
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items using addButtonPressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        var textField = UITextField()
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // what will happen once the user clicks the Add Item button on our UIAlert
       
                if let textFieldValid = textField.text {
                    if textFieldValid != "" {
                        let tempItem : Item = Item(context: self.context)
                        tempItem.title = textFieldValid
                        tempItem.done = false
                        tempItem.parentCategory = self.selectedCategory
                        self.itemArray.append(tempItem)
                        self.saveItems()
                    }

                }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
   
    
    //MARK: - Model Manupulation Methods
    
    //TODO: add saveItems() method, encoding
    func saveItems(){
        do{
            try context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    //TODO: add loadItems() method, decoding
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(),with predicate : NSPredicate? = nil){
   
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }
        else {
            request.predicate = categoryPredicate
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//        request.predicate = compoundPredicate
        do {
        itemArray = try context.fetch(request)
        }
        catch{
            print("Error fetching data from context \(error)" )
        }
        tableView.reloadData()
    }

}


//MARK: - Search bar delegate methods
extension TodoListViewController: UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, with: predicate)
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
