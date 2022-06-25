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

_Just added file name to the list, next to image. Like this;_

```swift
let vc = UIActivityViewController(activityItems: [image, "This is my image name"], applicationActivities: [])
```

- [x] Go back to project 1 and add a bar button item to the main view controller that recommends the
      app.</br><br>
      _Added UIBarButtonItem and the function_

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

- [x] Go back to project 2 and add a right bar button item that shows their score whenever it's tapped.</br><br>
      _Added UIBarButtonItem and the function to ViewController_

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

- I will change the UI in the future. I've been trying to give some padding between the cells for about literally 2 hours. That is too frustrating. I will leave it as it is for now.

<img src = "https://user-images.githubusercontent.com/30066961/174459222-a4f7e207-1c3e-48fe-9070-e2d58b2bbe21.png" width = 30%> <img src = "https://user-images.githubusercontent.com/30066961/174459242-399e13dc-1d85-46fe-bdad-b3ab98a3dd75.png" width = 30%> <img src = "https://user-images.githubusercontent.com/30066961/174459244-540258ae-7a21-47bf-94da-570cb17d70d2.png" width = 30%>

## 2022-06-19 SUN

#### Day 24,25,26 is done without challenges

- WKWebView
- Delegations in swift
- URLRequest, URL
- UIToolbar
- UIProgressView
- Most important observer in swift: Value-Key-Observer

#### Day 26 Challenges

- [x] If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked<br><br>
      _I created a UIAlertController to show alert and I put it inside of function. Finally I called the function inside webView decision handler_<br>

```swift
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host{
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
            showAlert(host: host) // Here I called showAlert function
        }
        decisionHandler(.cancel)
    }

    func showAlert(host: String){
        let ac = UIAlertController(title: "Unsupported website", message: "You can't open the host \(host)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
```

<img src = "https://user-images.githubusercontent.com/30066961/174487308-ca325b63-7323-4169-8853-1a163d53a46c.png" width = 30%>

- [x] Try making two new toolbar items with the titles Back and Forward. You should make them use `webView.goBack` and `webView.goForward`<br><br>
      _Created two UIBarButtonItem called goBack and goForward and I add them to toolbarItems with one extra spacer between goForward and refresh button._

- [x] Try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front.<br><br>
      _I used programmatically view for this challenge. This tutorial from Martin Lasek helped a lot: https://martinlasek.medium.com/tutorial-adding-a-uitableview-programmatically-433cb17ae07d<br>Please don't forget giving tableView delegate and dataSource to self (tableView you created). I forgot and I worked ~2 hours to find what cause the error. It was these 2 lines._

```swift
  tableView.dataSource = self // you can't see tableView items if you don't give dataSource itself
  tableView.delegate = self // you can't click tableView if you don't give delegate itself
```

<img src = "https://user-images.githubusercontent.com/30066961/174504389-b6e4321c-b7fa-477d-98bb-90c32131278f.png" width = 30%> <img src = "https://user-images.githubusercontent.com/30066961/174504404-6062b487-d2b6-458b-93d4-2220ba100972.png" width = 30%>

## 2022-06-20 MON

#### Day 27,28,29 is done without challenges

- Reloading Table Views
- Strings and UTF16
- Text input from user
- Inserting rows to Table View
- Closures

- [x] Disallow answers that are shorter than three letters or are just our start word<br><br>
      _Created 2 functions_

```swift
    if (!isAcceptableLength(word: lowerAnswer)){
              showErrorMessage(title: "Word length is not enough", description:  "Word length need to be greater than 3")
              return
          }
    if (!isWordEqualsTitle(word: lowerAnswer)){
              showErrorMessage(title: "Word not possible", description:  "You can't enter the same word as title")
            return
        }
    func isAcceptableLength(word: String) -> Bool {
        return word.count > 3
    }

    func isWordEqualsTitle(word: String) -> Bool {
        guard let title = title else { return false }
        return word != title
    }
```

<img src = "https://user-images.githubusercontent.com/30066961/174685481-6d5515de-0aee-4c43-814c-bf24e946eefe.png" width = 30%> <img src = "https://user-images.githubusercontent.com/30066961/174685608-a0f61a1a-4b4d-497b-a3c3-32142c918c1b.png" width = 30%> <br>

- [x] Refactor all the else statements we just added so that they call a new method called showErrorMessage()<br>

```swift
 func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()

        if (!isReal(word: lowerAnswer)){
            showErrorMessage(title: "Word not recognized", description:  "You can't just make that up, you know")
            return
        }
        if (!isOriginal(word: lowerAnswer)){
            showErrorMessage(title: "Word already used", description:  "Be more original!")
            return
        }
        if (!isPossible(word: lowerAnswer)){
            guard let title = title else {
                self.showErrorMessage(title: "Word not possible", description:  "You can't spell that from given word")
                return
            }
            showErrorMessage(title: "Word not possible", description:  "You can't spell that word from \(title.lowercased())")
            return
        }

        usedWords.insert(answer, at: 0)
        let indexPath = IndexPath(row:0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    func showErrorMessage(title: String, description: String){
        let ac = UIAlertController(title: title, message: description, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
```

- [x] Add a left button item that calls startGame(), so users can restart wih a new word whenever they want to <br><br>
      _I added leftBarButtonItem to navigationItem and point it to startGame function we already created before. After that I just needed to add @objc to the start of the func keyword. Because UIBarButtonItem selector function need to be tagged @objc_

```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, targetself, action: #selector(startGame))

@objc func startGame(){
```

## 2022-06-21 TUE

#### Day 30 is done

- Advanced Layout 101
- Basics of Visual Format Language
- @999 -> This is interesting. I've never seen anything like this before. I need to learn what is it.

## 2022-06-22 WED

Day off

## 2022-06-23 THU

Day off

## 2022-06-24 FRI

### Day 31 is done

- Equal height on child widgets
- Anchors<br>

- [x] Try replacing the widthAnchor of our labels with leadingAnchor and trailingAnchor constraints, which more explicitly pin the label to the edges of its parent.<br>

```swift
label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
```

- [x] Once you’ve completed the first challenge, try using the safeAreaLayoutGuide for those constraints. You can see if this is working by rotating to landscape, because the labels won’t go under the safe area.<br>

```swift
label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
```

- [x] Try making the height of your labels equal to 1/5th of the main view, minus 10 for the spacing. This is a hard one, but I’ve included hints below!<br>

```swift
label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
```

## 2022-06-24 FRI

### Milestone project - day 32 is done

[Go to ViewController.swift to see changes](https://github.com/cem-ergin/HackingWithSwift/blob/master/Milestone%20Project%204-6/Milestone%20Project%204-6/ViewController.swift)

- [x] Create an app that lets people create a shopping list by adding items to a table view <br>

<img src = "https://user-images.githubusercontent.com/30066961/175775215-edf2b5b2-0638-4d39-b5dd-f1ef82559ae1.png" width = 23%> <img src = "https://user-images.githubusercontent.com/30066961/175775194-365b4ecc-b79e-4da8-942d-52b43a0818ae.png" width = 23%> <img src = "https://user-images.githubusercontent.com/30066961/175775392-8353c06a-a17d-4fff-9930-7a6ea1c10305.png" width = 23%> 

## 2022-06-25 SAT

### Day 33, 34 and 35 is completed. Project 7 is complete without challenges.

- Codable
- Parsing JSON
- Getting data from internet
- UITabBarController
- UIStoryBoard
- SceneDelegate

[Go to Project 7 to see the challenge answers](https://github.com/cem-ergin/HackingWithSwift/tree/master/Project%207%20-%20Whitehouse%20Petitions)

- [x] Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.<br>
```swift
let showInfoButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showInfo))

@objc func showInfo() {
let ac = UIAlertController(title: "Credits", message: "All the data coming from 'We The People Api' of the Whitehouse", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "OK", style: .default))
present(ac, animated: true)
}
```
- [x] Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string.<br>
```swift
let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filter))
navigationItem.rightBarButtonItems = [showInfoButton, searchButton]
```
```swift
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
    
    func reloadData () {
        navigationItem.leftBarButtonItem = filteredPetitions.count != petitions.count ? clearButton : nil
        tableView.reloadData()
    }
```

- [ ] Experiment with the HTML

<img src = "https://user-images.githubusercontent.com/30066961/175790994-d5404ecc-2b5a-48bb-b791-01bc5069cb51.gif" width = 30%>

### Day 36 is completed

- Building app without storyboard
- Making complex ui programmatically.