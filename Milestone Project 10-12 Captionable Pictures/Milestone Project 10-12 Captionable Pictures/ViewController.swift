//
//  ViewController.swift
//  Milestone Project 10-12 Captionable Pictures
//
//  Created by Cem Ergin on 28/07/2022.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pictures : [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pictures"
        loadData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takeImage))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureViewCell
        let picture = pictures[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(picture.imageName)
        
        cell.myImageView.image = UIImage(contentsOfFile: path.path)
        cell.titleLabel.text = picture.imageName
        cell.captionLabel.text = picture.caption
        
        cell.addCaptionButton.setTitle("\(picture.caption.isEmpty ? "Add" : "Update") Caption", for: .normal)
        cell.addCaptionButton.addTarget(self, action: #selector(addCaption), for: .touchUpInside)
        cell.addCaptionButton.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pictures.remove(at: indexPath.row)
            updateDatabase()
            loadData()
        }
    }
    
    @objc func addCaption(sender: UIButton) {
        let isAdd = self.pictures[sender.tag].caption.isEmpty
        
        let ac = UIAlertController(title: "\(isAdd ? "Add" : "Update") Caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            [weak ac] _ in
            if let captionText = ac?.textFields?.first?.text {
                self.pictures[sender.tag].caption = captionText
                self.updateDatabase()
                self.loadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? PictureDetailViewController {
            let imagePath = getDocumentsDirectory().appendingPathComponent(pictures[indexPath.item].imageName).path
            vc.myImage = UIImage(contentsOfFile: imagePath)
            vc.myTitle = pictures[indexPath.item].imageName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    @objc func takeImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let picture = Picture(imageName: imageName, caption: "")
        savePictureToDatabase(picture: picture)
        loadData()
        dismiss(animated: true)
    }
    
    func loadData() {
        let userDefaults = UserDefaults.standard
        if let savedPictures = userDefaults.object(forKey: "pics") as? Data {
            do {
                let jsonDecoder = JSONDecoder()
                pictures = try jsonDecoder.decode([Picture].self, from: savedPictures)
                tableView.reloadData()
            } catch let error {
                print("Failed to load pictures: \(error.localizedDescription)")
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func savePictureToDatabase(picture: Picture) {
        let jsonEncoder = JSONEncoder()
        let jsonDecoder = JSONDecoder()
        let picturesKey = "pics"
        
        let userDefaults = UserDefaults.standard
        if let savedPictures = userDefaults.object(forKey: picturesKey) as? Data {
            do {
                var pictures = try jsonDecoder.decode([Picture].self, from: savedPictures)
                pictures.append(picture)
                userDefaults.set(try! jsonEncoder.encode(pictures), forKey: picturesKey)
            } catch let error {
                print("Failed to load pictures: \(error.localizedDescription)")
            }
        } else {
            userDefaults.set(try! jsonEncoder.encode([picture]), forKey: picturesKey)
        }
    }
    
    func updateDatabase() {
        let jsonEncoder = JSONEncoder()
        let picturesKey = "pics"
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(try! jsonEncoder.encode(pictures), forKey: picturesKey)
    }
}

