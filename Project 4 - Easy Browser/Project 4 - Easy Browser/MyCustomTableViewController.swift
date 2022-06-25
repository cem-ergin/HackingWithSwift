//
//  MyCustomTableViewController.swift
//  Project 4 - Easy Browser
//
//  Created by Cem Ergin on 19/06/2022.
//

import UIKit

class MyCustomTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    var websites =  [String]()

    override func loadView() {
       super.loadView()
        setupTableView()
     }
    
    func setupTableView() {
      view.addSubview(tableView)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        websites = ["apple.com","hackingwithswift.com","flutter.dev"]
        title = "Frustrated because of this"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let websiteViewController = ViewController()
        websiteViewController.modalPresentationStyle = .fullScreen
        websiteViewController.website = websites[indexPath.row]
        self.navigationController!.pushViewController(websiteViewController, animated: true)
    }
}
