//
//  GameScene.swift
//  CoinMan
//
//  Created by Raúl Torres on 12/07/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let coinManCategory : UInt32 = 0x1 << 1
    let cookieCategory : UInt32 = 0x1 << 2
    let onionCategory : UInt32 = 0x1 << 3
    let groundAndCeilCategory : UInt32 = 0x1 << 4
    
//    var ground : SKSpriteNode?
    var ceil: SKSpriteNode?
    var coinMan : SKSpriteNode?
    var cookieTimer : Timer?
    var onionTimer : Timer?
    var scoreLabel : SKLabelNode?
    var yourScroreLabel : SKLabelNode?
    var finalScroreLabel : SKLabelNode?
    
    var coinManJump = [SKTexture]()
    
    var score = 0
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        coinMan?.physicsBody?.categoryBitMask = coinManCategory
        coinMan?.physicsBody?.contactTestBitMask = cookieCategory | onionCategory
        coinMan?.physicsBody?.collisionBitMask = groundAndCeilCategory
        
        var coinManRun = [SKTexture]()
        
        for number in 0...20 {
            coinManRun.append(SKTexture(imageNamed: "rr_0" + (number >= 10 ? "\(number)" : "0\(number)")))
        }

        coinMan?.run(SKAction.repeatForever(SKAction.animate(with: coinManRun, timePerFrame: 0.02)))

        for number in 0...17 {
            coinManJump.append(SKTexture(imageNamed: "l_0" + (number >= 10 ? "\(number)" : "0\(number)")))
        }
        
//        ground = childNode(withName: "ground") as? SKSpriteNode
//        ground?.physicsBody?.categoryBitMask = groundAndCeilCategory
//        ground?.physicsBody?.collisionBitMask = coinManCategory
        
        ceil = childNode(withName: "ceil") as? SKSpriteNode
        ceil?.physicsBody?.categoryBitMask = groundAndCeilCategory
        ceil?.physicsBody?.collisionBitMask = coinManCategory
        
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        
        startTimers()
        createGrass()
    }
    
    func createGrass() {
        let sizingGrass = SKSpriteNode(imageNamed: "grass")
        let numberOfGrass = Int(size.width / sizingGrass.size.width) + 1
        for number in 0...numberOfGrass {
            let grass = SKSpriteNode(imageNamed: "grass")
            grass.physicsBody = SKPhysicsBody(rectangleOf: grass.size)
            grass.physicsBody?.categoryBitMask = groundAndCeilCategory
            grass.physicsBody?.collisionBitMask = coinManCategory
            grass.physicsBody?.affectedByGravity = false
            grass.physicsBody?.isDynamic = false
            addChild(grass)
            
            let grassX = -size.width / 2 + grass.size.width / 2 + grass.size.width * CGFloat(number)
            grass.position = CGPoint(x: grassX, y: -size.height / 2 + grass.size.height / 2 - 18)
            
            let speed = 100.0
            
            let moveLeft = SKAction.moveBy(x: -grass.size.width - grass.size.width * CGFloat(number) , y: 0, duration: TimeInterval(grass.size.width + grass.size.width * CGFloat(number)) / speed)
            
            let resetGrass = SKAction.moveBy(x: size.width + grass.size.width, y: 0, duration: 0)
            let grassFullMove = SKAction.moveBy(x: -size.width - grass.size.width, y: 0, duration: TimeInterval(grass.size.width + grass.size.width * CGFloat(number)) / speed)
            let grassMoving = SKAction.repeatForever(SKAction.sequence([grassFullMove, resetGrass]))
            
            grass.run(SKAction.sequence([moveLeft,resetGrass,grassMoving]))
        }
    }
    
    func startTimers(){
        cookieTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            //            self.createCookie()
            
            let cookie = SKSpriteNode(imageNamed: "cookie")
            self.createCookieOrOnion(obj: cookie, category: self.cookieCategory)
            
            
        })
        
        onionTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            let onion = SKSpriteNode(imageNamed: "onion")
            self.createCookieOrOnion(obj: onion, category: self.onionCategory)
            //            self.createOnion()
        })
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !(scene?.isPaused)! {
            coinMan?.physicsBody?.applyForce(CGVector(dx: 0, dy: 100_000))
            coinMan?.run(SKAction.animate(with: coinManJump, timePerFrame: 0.05))
        }
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let theNodes = nodes(at: location)
            for node in theNodes {
                if node.name == "play" {
                    
                    score = 0
                    node.removeFromParent()
                    finalScroreLabel?.removeFromParent()
                    yourScroreLabel?.removeFromParent()
                    scene?.isPaused = false
                    scoreLabel?.text = "Score: \(score)"
                    startTimers()
                }
            }
        }
    }
    
    func createCookie(){
        let cookie = SKSpriteNode(imageNamed: "cookie")
        cookie.physicsBody = SKPhysicsBody(rectangleOf: cookie.size)
        cookie.physicsBody?.affectedByGravity = false
        cookie.physicsBody?.categoryBitMask = cookieCategory
        cookie.physicsBody?.contactTestBitMask = coinManCategory
        cookie.physicsBody?.collisionBitMask = 0
        addChild(cookie)
        
        
        let sizingGrass = SKSpriteNode(imageNamed: "grass")
        
        let maxY = size.height / 2 - cookie.size.height / 2
        let minY = -size.height / 2 + cookie.size.height / 2 + sizingGrass.size.height
        let range = maxY - minY
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        cookie.position = CGPoint(x: size.width / 2 + cookie.size.width / 2, y: coinY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - cookie.size.width, y: 0, duration: 4)
        let rotation = SKAction.rotate(byAngle: CGFloat(Int.random(in: 1...45)), duration: 4)
        
        cookie.run(rotation)
        cookie.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }
    
    func createOnion(){
        let onion = SKSpriteNode(imageNamed: "onion")
        onion.physicsBody = SKPhysicsBody(rectangleOf: onion.size)
        onion.physicsBody?.affectedByGravity = false
        onion.physicsBody?.categoryBitMask = onionCategory
        onion.physicsBody?.contactTestBitMask = coinManCategory
        onion.physicsBody?.collisionBitMask = 0
        addChild(onion)
        
        let sizingGrass = SKSpriteNode(imageNamed: "grass")
        
        let maxY = size.height / 2 - onion.size.height / 2
        let minY = -size.height / 2 + onion.size.height / 2 + sizingGrass.size.height
        let range = maxY - minY
        let onionY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        onion.position = CGPoint(x: size.width / 2 + onion.size.width / 2, y: onionY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - onion.size.width, y: 0, duration: 4)
        let rotation = SKAction.rotate(byAngle: CGFloat(Int.random(in: 1...45)), duration: 4)
        
        onion.run(rotation)
        onion.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }
    
    func createCookieOrOnion(obj: SKSpriteNode, category: UInt32){
        obj.physicsBody = SKPhysicsBody(rectangleOf: obj.size)
        obj.physicsBody?.affectedByGravity = false
        obj.physicsBody?.categoryBitMask = category
        obj.physicsBody?.contactTestBitMask = coinManCategory
        obj.physicsBody?.collisionBitMask = 0
        addChild(obj)

        let maxY = size.height / 2 - obj.size.height / 2
        let minY = -size.height / 2 + obj.size.height / 2
        let range = maxY - minY
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))

        obj.position = CGPoint(x: size.width / 2 + obj.size.width / 2, y: coinY)

        let moveLeft = SKAction.moveBy(x: -size.width - obj.size.width, y: 0, duration: 4)
        let rotation = SKAction.rotate(byAngle: CGFloat(Int.random(in: 1...45)), duration: 4)

        obj.run(rotation)
        obj.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
        
       
        if contact.bodyA.categoryBitMask == cookieCategory {
            contact.bodyA.node?.removeFromParent()
             score += 1
        }

        if contact.bodyB.categoryBitMask == cookieCategory {
            contact.bodyB.node?.removeFromParent()
             score += 1
        }
        
        if contact.bodyA.categoryBitMask == onionCategory  {
            print("game over")
            contact.bodyB.node?.removeFromParent()
            gameOver()
        }
        
        if contact.bodyB.categoryBitMask == onionCategory {
            print("game over")
            contact.bodyB.node?.removeFromParent()
            gameOver()
        }
        
        scoreLabel?.text = "Score: \(score)"
    }

    
    func gameOver() {
        scene?.isPaused = true
        
        yourScroreLabel = SKLabelNode(text: "Your score:")
        yourScroreLabel?.position = CGPoint(x: 0, y: 200)
        yourScroreLabel?.fontSize = 100
        yourScroreLabel?.zPosition = 1
        if yourScroreLabel != nil {
            addChild(yourScroreLabel!)
        }
        
        finalScroreLabel = SKLabelNode(text: "\(score)")
        finalScroreLabel?.position = CGPoint(x: 0, y: 0)
        finalScroreLabel?.fontSize = 150
        finalScroreLabel?.zPosition = 1
        if finalScroreLabel != nil {
            addChild(finalScroreLabel!)
        }
        
        let playBtn = SKSpriteNode(imageNamed: "play")
        playBtn.position = CGPoint(x: 0, y: -200)
        playBtn.name = "play"
        playBtn.zPosition = 1
        addChild(playBtn)
        
        cookieTimer?.invalidate()
        onionTimer?.invalidate()
    }
    
    
}
