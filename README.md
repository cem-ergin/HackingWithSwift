# HackingWithSwift - 100 DAYS OF SWIFT
Hacking with Swift Course by Paul Hudson, for details [Hacking with Swift 100 days challenge](https://hackingwithswift.com/100)

## General Todo's
- [ ] Learn what to use, [[MVVM vs MVC]] 


## 2022-06-16 THU

#### Day 16 is done
What I learn is;
- A bit about Storyboard.
- FileManager class
- Listview 
- dequeueReusableCell and override functions of tableView

#### Day 17 is done
- @IBOutlet is just a connection keyword between storyboard and code
- UIImageView
- AutoLayout
- UIImage()
- Navigate to a new screen
- Hiding and customising Navigation bars 

## 2022-06-17 FRI
#### Day 17, 18, 19, 20 and 21 is done
- UIButton
- UIColor
- Actions
- UIAlertController
- present()

## 2022-06-18 SAT
#### Day 22 is done
- UIBarButtonItem
- UIActivityViewController
- Share an item(Image, Text. Whatever. It's dynamic)

#### Some challenges of day 22; 
- [x] Add the image name to your shared items. 

*Just added file name to the list, next to image. Like this;*
```swift
let vc = UIActivityViewController(activityItems: [image, "This is my image name"], applicationActivities: [])
```
- [x] Go back to project 1 and add a bar button item to the main view controller that recommends the 
app.</br>
*Added UIBarButtonItem and the function*
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

<img src="https://user-images.githubusercontent.com/30066961/174457463-b167c164-a5cb-4a37-9568-7c1c042ba791.png" width="30%">

- [x] Go back to project 2 and add a right bar button item that shows their score whenever it's tapped.</br>
*Added UIBarButtonItem and the function to ViewController*
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
```
```swift
     @objc func showScore(){
        let ac = UIAlertController(title: "Your score", message: "Your current score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(ac) -> Void in
            print("showScore handler")
        }))
        present(ac, animated: true)
    }
```

<img src="https://user-images.githubusercontent.com/30066961/174457759-2a6d04d7-2db5-44f1-87fa-5ff42944123a.png" width="30%">

#### Day 23, Challenge
- Challenge is
1. Show the flags with their names and images
2. Show detail screen of the flag that is fullscreen image of flag.
3. Share flag with it's name.</br>
- I will change the UI in the future. I am trying to give some padding between the cells for about literally 2 hours. That is too frustrating. I will leave it as it is for now. 

|<img src = "https://user-images.githubusercontent.com/30066961/174459222-a4f7e207-1c3e-48fe-9070-e2d58b2bbe21.png" width = 30%>|<img src = "https://user-images.githubusercontent.com/30066961/174459242-399e13dc-1d85-46fe-bdad-b3ab98a3dd75.png" width = 30%>|<img src = "https://user-images.githubusercontent.com/30066961/174459244-540258ae-7a21-47bf-94da-570cb17d70d2.png" width = 30%>

## 2022-06-19 SUN
#### Day 24,25,26 is done without challenges
- WKWebView
- Delegations in swift
- URLRequest, URL
- UIToolbar
- UIProgressView
- Most important observer in swift: Value-Key-Observer

#### Day 26 Challenges
- [ ] If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked
- [ ] Try making two new toolbar items with the titles Back and Forward. You should make them use `webView.goBack` and `webView.goForward`
- [ ] Try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front.
