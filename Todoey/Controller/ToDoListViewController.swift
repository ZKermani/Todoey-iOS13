//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var items = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        cell.accessoryType   = items[indexPath.row].done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].done = !items[indexPath.row].done
        tableView.reloadData()
        saveData()
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var newItem = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            let item = Item(context: self.context)
            item.title = newItem.text!
            item.done = false
            self.items.append(item)
            self.tableView.reloadData()
            self.saveData()
        }))
        
        alert.addTextField { textField in
            textField.placeholder = "New item"
            newItem = textField
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error while saving data \(error)")
        }
    }
    
    func loadData() {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            items = try context.fetch(fetchRequest)
        } catch {
            print("Error while loading data \(error)")
        }
    }
}
