//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var items = [Item]()
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Items.plist")

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
            let item = Item()
            item.title = newItem.text!
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
        let encoder = PropertyListEncoder()
        do {
            let encodedData = try encoder.encode(items)
            try? encodedData.write(to: filePath)
        } catch {
            print("Encoding has encountered an error \(error)")
        }
    }
    
    func loadData() {
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: filePath)
            if let decodedData = try? decoder.decode([Item].self, from: data) {
                items = decodedData
            } else {
                print("Decoding has encountered an error")
            }
        } catch {
            print("Reading data has encountered an error \(error)")
        }
    }
}
