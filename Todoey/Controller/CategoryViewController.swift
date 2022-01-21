//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Zahra Sadeghipoor on 1/21/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].title
        return cell
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newCategory = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            let category = Category(context: self.context)
            category.title = newCategory.text!
            self.categories.append(category)
            self.tableView.reloadData()
            self.saveData()
        }))
        
        alert.addTextField { textField in
            textField.placeholder = "New category"
            newCategory = textField
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error while saving data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(with fetchRequest: NSFetchRequest<Category> = NSFetchRequest<Category>(entityName: "Category")) {
        
        do {
            categories = try context.fetch(fetchRequest)
        } catch {
            print("Error while loading data \(error)")
        }
        tableView.reloadData()
    }
    
}
