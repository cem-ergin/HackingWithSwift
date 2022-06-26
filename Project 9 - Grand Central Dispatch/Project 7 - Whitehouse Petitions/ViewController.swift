//
//  ViewController.swift
//  Project 7 - Whitehouse Petitions
//
//  Created by Cem Ergin on 25/06/2022.
//

import UIKit

class ViewController: UITableViewController {
    var urlString: String!

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var clearButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearData))
        let showInfoButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showInfo))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filter))
        navigationItem.rightBarButtonItems = [showInfoButton, searchButton]
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        performSelector(inBackground: #selector(fetchJson), with: nil)
        
    }
    
    @objc func fetchJson(){
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func clearData (){
        filteredPetitions = petitions
        reloadData()
    }
    
    @objc func filter() {
        let ac = UIAlertController(title: "Filter", message: "Type something to search", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak ac] _ in
            if let text = ac?.textFields?[0].text {
                self.filterData(filterString: text)
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(ac, animated: true)
    }
    
    func filterData (filterString: String) {
        if(filterString.isEmpty){
            filteredPetitions = petitions
        }else{
            filteredPetitions = petitions.filter({ Petition in
                return Petition.body.contains(filterString) || Petition.title.contains(filterString)
            })
        }
        reloadData()
    }
    
    @objc func reloadData () {
        navigationItem.leftBarButtonItem = filteredPetitions.count != petitions.count ? clearButton : nil
        tableView.reloadData()
//        performSelector(onMainThread: #selector(leftBarButtonHandler), with: nil, waitUntilDone: false)
//        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    @objc func leftBarButtonHandler(){
        navigationItem.leftBarButtonItem = filteredPetitions.count != petitions.count ? clearButton : nil
    }
    
    
    @objc func showInfo() {
        let ac = UIAlertController(title: "Credits", message: "All the data coming from 'We The People Api' of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showError(){
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. Please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            performSelector(onMainThread: #selector(reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

