//
//  ViewController.swift
//  Milestone Project 4-6
//
//  Created by CTW01856-Admin on 25/06/2022.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearItems))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func addItem(){
        let ac = UIAlertController(title: "Add item", message: "Please add your item", preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Submit", style: .default){
            [weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self.shoppingList.append(item)
            self.tableView.reloadData()
        }
        
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    @objc func clearItems(){
        shoppingList.removeAll()
        tableView.reloadData()
    }
}

