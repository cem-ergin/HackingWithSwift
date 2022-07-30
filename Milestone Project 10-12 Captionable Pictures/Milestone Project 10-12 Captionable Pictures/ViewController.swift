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
        
        
        let userDefaults = UserDefaults.standard
        if let savedPictures = userDefaults.object(forKey: "myPictures") as? Data {
            print("saved pictures: \(savedPictures)")
            for picture in savedPictures {
                print(picture)
            }
            let jsonDecoder = JSONDecoder()
            do {
//                pictures = try jsonDecoder.decode([Picture].self, from: Picture)
            } catch {
                print("Failed to load pictures")
            }
        } else {
            print("savedPictures are not available")
        }

        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takeImage))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureViewCell
        let picture = pictures[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(picture.imageName)

        cell.myImageView.image = UIImage(contentsOfFile: path.path)
        cell.titleLabel.text = picture.imageName
        cell.captionLabel.text = picture.caption
        return cell
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
        
        let picture = Picture(imageName: imageName)
        pictures.append(picture)
        savePictureToDatabase(picture: picture)
        dismiss(animated: true)
        tableView.reloadData()
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func savePictureToDatabase(picture: Picture) {
        let jsonEncoder = JSONEncoder()
        let picturesKey = "pictures"
        
        let userDefaults = UserDefaults.standard
        
        if let encodedPicture = try? jsonEncoder.encode(picture) {
//            if var pictureList = userDefaults.object(forKey: picturesKey) as? [Picture] {
//                pictureList.append(picture)
//                userDefaults.set(encodedPicture, forKey: picturesKey)
//            } else {
                userDefaults.set(encodedPicture, forKey: picturesKey)
//            }
        }
    }
}

