//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let items = ["Job1", "Job2", "Job3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
//        print(items[indexPath.row])
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        if let currentText = tableView.cellForRow(at: indexPath)?.textLabel?.text {
            if currentText.starts(with: "✅") {
                tableView.cellForRow(at: indexPath)?.textLabel?.text = items[indexPath.row]
            } else {
                tableView.cellForRow(at: indexPath)?.textLabel?.text =  "✅  " + currentText
            }
        }
        
    }
}
