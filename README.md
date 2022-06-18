# HackingWithSwift - 100 DAYS OF SWIFT
Hacking with Swift Course by Paul Hudson, for details [Hacking with Swift 100 days challenge](https://hackingwithswift.com/100)

##### General Todo's
- [ ] Learn what to use, [[MVVM vs MVC]] 


##### 2022-06-16 THU

###### Day 16 is done
What I learn is;
- A bit about Storyboard.
- FileManager class
- Listview 
- dequeueReusableCell and override functions of tableView

###### Day 17 is done
- @IBOutlet is just a connection keyword between storyboard and code
- UIImageView
- AutoLayout
- UIImage()
- Navigate to a new screen
- Hiding and customising Navigation bars 

##### 2022-06-17 FRI
###### Day 17, 18, 19, 20 and 21 is done
- UIButton
- UIColor
- Actions
- UIAlertController
- present()

##### 2022-06-18 SAT
###### Day 22 is done
- UIBarButtonItem
- UIActivityViewController
- Share an item(Image, Text. Whatever. It's dynamic)

###### Some challenges; 
- [x] Add the image name to your shared items. 

*Just added file name to the list, next to image. Like this;*
```swift
let vc = UIActivityViewController(activityItems: [image, "This is my image name"], applicationActivities: [])
```
- [x] Go back to project 1 and add a bar button item to the main view controller that recommends the 
app.</br>
*Added UIBarButtonItem and the function
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
```
```swift
  @objc func shareTapped (){
        let appUrl = "You must try this app! https://github.com/cem-ergin/HackingWithSwift"
        let vc = UIActivityViewController(activityItems: [appUrl], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem  = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
```

<img src="https://user-images.githubusercontent.com/30066961/174457463-b167c164-a5cb-4a37-9568-7c1c042ba791.png" width="45%">

- [ ] Go back to project 2 and add a right bar button item that shows their score whenever it's tapped.
