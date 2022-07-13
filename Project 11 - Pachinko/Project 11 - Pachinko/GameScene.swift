//
//  GameScene.swift
//  Project 11 - Pachinko
//
//  Created by Cem Ergin on 10/07/2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate, Alertable {
    let balls = ["ballBlue","ballCyan","ballGreen","ballGrey","ballPurple","ballRed","ballYellow"]
    
    var didBallTouchedBlock = false
        
    var ballCountLabel: SKLabelNode!
    var ballCount = 5 {
        didSet {
            ballCountLabel.text = "Balls left: \(ballCount)"
            if(ballCount == 0){
                showAlert(withTitle: "Game Over", message: "You don't have any ball left :(", completion: reload)
            }
        }
    }
    
    var reloadLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        ballCountLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballCountLabel.horizontalAlignmentMode = .right
        ballCountLabel.position = CGPoint(x:980, y:700)
        addChild(ballCountLabel)
        ballCount = 5
        
        reloadLabel = SKLabelNode(fontNamed: "Chalkduster")
        reloadLabel.text = "Reload"
        reloadLabel.position = CGPoint(x: 80, y: 700)
        addChild(reloadLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x:0, y:0))
        makeBouncer(at: CGPoint(x:256, y:0))
        makeBouncer(at: CGPoint(x:512, y:0))
        makeBouncer(at: CGPoint(x:768, y:0))
        makeBouncer(at: CGPoint(x:1024, y:0))
                
        createBoxes()
        
    }
    
    fileprivate func createBoxes() {
        for _ in 0..<50 {
            createBox(CGPoint(x: CGFloat.random(in: 0...frame.width), y: CGFloat.random(in: (frame.height * 0.4)...(frame.height * 0.7))))
        }
    }
    
    fileprivate func createBox(_ location: CGPoint) {
        let size = CGSize(width: Int.random(in: 32...128), height: 16)
        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        box.name = "box"
        addChild(box)
    }
    
    fileprivate func createBall(_ location: CGPoint) {
        if ballCount > 0 {
            if self.childNode(withName: "ball") == nil {
                let ball = SKSpriteNode(imageNamed: balls.randomElement() ?? "ballRed")
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.restitution = 0.4
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.position = CGPoint(x: location.x, y: frame.height * 0.9)
                ball.name = "ball"
                addChild(ball)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if objects.contains(reloadLabel) {
            reload()
        } else {
            didBallTouchedBlock = false
            createBall(location)
        }
    }
    
    func reload () {
        for node in self.children {
            if node.name == "box" || node.name == "ball" {
                node.removeFromParent()
            }
        }
        
        self.ballCount = 5
        self.createBoxes()
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position:CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            if didBallTouchedBlock {
                ballCount += 1
            } else {
                ballCount -= 1
            }
        } else if object.name == "bad"{
            destroy(ball: ball)
            ballCount -= 1
        }
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    
    func destroy(box: SKNode) {
        if let sparkParticles = SKEmitterNode(fileNamed: "SparkParticles") {
            sparkParticles.position = box.position
            addChild(sparkParticles)
        }
        
        box.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
        
        if nodeA.name == "box" {
            destroy(box: nodeA)
            didBallTouchedBlock = true
        } else if nodeB.name == "box" {
            destroy(box: nodeB)
            didBallTouchedBlock = true
        }
        
        if self.childNode(withName: "box") == nil {
            showAlert(withTitle: "You won!", message: "Wanna play more?", completion: reload)
        }
    }
    
}


protocol Alertable { }
extension Alertable where Self: SKScene {
    func showAlert(withTitle title: String, message: String, completion: @escaping () -> Void) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion()
        }
        alertController.addAction(okAction)

        view?.window?.rootViewController?.present(alertController, animated: true)
    }
}
