//
//  ViewController.swift
//  ProjectOne
//
//  Created by Cem Ergin on 16/06/2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(getData), with: nil)
        
    }
    
    @objc func getData(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if (item.hasPrefix("nssl")){
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let selectedImage = pictures[indexPath.row]
            increaseCount(pictureKey: selectedImage)
            vc.selectedImage = selectedImage
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped (){
        let appUrl = "You must try this app! https://github.com/cem-ergin/HackingWithSwift"
        let vc = UIActivityViewController(activityItems: [appUrl], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem  = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func increaseCount(pictureKey: String) {
        let defaults = UserDefaults.standard
        if let count = defaults.object(forKey: pictureKey) as? Int {
            defaults.set(count + 1, forKey: pictureKey)
        } else {
            defaults.set(1, forKey: pictureKey)
        }
    }
}

