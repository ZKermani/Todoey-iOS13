//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var items = [Item()]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let newItem1 = Item()
        newItem1.title = "Job1"
        items.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Job2"
        items.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Job3"
        items.append(newItem3)
        
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
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var newItem = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            let item = Item()
            item.title = newItem.text!
            self.items.append(item)
            self.tableView.reloadData()
        }))
        
        alert.addTextField { textField in
            textField.placeholder = "New item"
            newItem = textField
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
