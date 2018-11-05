//
//  GameScene.swift
//  FlappyBird
//
//  Created by Raúl Torres on 15/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Object = 2
        case Gap = 4
    }
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    var timer = Timer()
    
    var gameOver = false
    var score = 0
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        setupGame()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if !gameOver {
//            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(makePipes), userInfo: nil, repeats: true)
            
            bird.physicsBody?.isDynamic = true
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 80))
        } else {
            gameOver = false
            score = 0
            self.speed = 1
            
            self.removeAllChildren()
            
            setupGame()
            
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setupGame() {
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(makePipes), userInfo: nil, repeats: true)
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animate(with: [birdTexture,birdTexture2], timePerFrame: 0.1)
        let flapForever = SKAction.repeatForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        bird.physicsBody?.isDynamic = false
        
        bird.position = CGPoint(x: self.frame.midX, y: self.bird.frame.midY)
        bird.run(flapForever)
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        self.addChild(bird)
        
        setBackground()
        
        let ground = SKNode()
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2 )
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        ground.physicsBody?.isDynamic = false
        
        ground.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        ground.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        ground.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        
        self.addChild(ground)
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "\(score)"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 2 - 70)
        
        self.addChild(scoreLabel)
    }
    
    @objc func makePipes() {
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width , dy: 0), duration: TimeInterval(self.frame.width / 100))
        
        let gapHeight = bird.size.height * 4
        let movementamount = arc4random() % UInt32( self.frame.height / 2)
        let pipeOffset = CGFloat(movementamount) - self.frame.height / 4
        
        let upPipeTexture = SKTexture(imageNamed: "pipe1.png")
        let upPipe = SKSpriteNode(texture: upPipeTexture)
        upPipe.position =  CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + upPipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset) //CGPoint(x: 0, y: self.frame.height / 2)
        upPipe.run(movePipes)
        
        upPipe.physicsBody = SKPhysicsBody(rectangleOf: upPipeTexture.size())
        upPipe.physicsBody?.isDynamic = false
        upPipe.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        upPipe.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        upPipe.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        
        upPipe.zPosition = -1
        self.addChild(upPipe)
        
        let downPipeTexture = SKTexture(imageNamed: "pipe2.png")
        let downPipe = SKSpriteNode(texture: downPipeTexture)
        downPipe.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - upPipeTexture.size().height / 2 - gapHeight/2 + pipeOffset) // -upPipe.position.y
        downPipe.run(movePipes)
        
        downPipe.physicsBody = SKPhysicsBody(rectangleOf: downPipeTexture.size())
        downPipe.physicsBody?.isDynamic = false
        downPipe.physicsBody?.contactTestBitMask = ColliderType.Object.rawValue
        downPipe.physicsBody?.categoryBitMask = ColliderType.Object.rawValue
        downPipe.physicsBody?.collisionBitMask = ColliderType.Object.rawValue
        
        downPipe.zPosition = -1
        self.addChild(downPipe)
        
        let gap = SKNode()
        gap.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeOffset)
        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: upPipeTexture.size().width, height: gapHeight))
        gap.physicsBody?.isDynamic = false
        gap.run(movePipes)
        
        gap.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        gap.physicsBody?.categoryBitMask = ColliderType.Gap.rawValue
        gap.physicsBody?.collisionBitMask = ColliderType.Gap.rawValue
        
        self.addChild(gap)
        
    }
    
    fileprivate func setBackground(){
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        let moveAnimation = SKAction.move(by: CGVector(dx: -bgTexture.size().width, dy: 0), duration: 5.0)
        let shiftBGAnimation = SKAction.move(by: CGVector(dx: bgTexture.size().width, dy: 0), duration: 0)
        let moveForever = SKAction.repeatForever(SKAction.sequence([moveAnimation,shiftBGAnimation]))
        
        for i in 0..<3 {
        
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width * CGFloat(i), y: self.frame.midY)
            bg.size.height = self.frame.height
            
            bg.run(moveForever)
            self.addChild(bg)
            
            bg.zPosition = -2
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if !gameOver {
            if contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue || contact.bodyB.categoryBitMask == ColliderType.Gap.rawValue {
                
                print("gappppppp")
                
                score += 1
                scoreLabel.text = "\(score)"
                
            } else {
                print("we have contact")
                
                gameOver = true
                
                timer.invalidate()
                
                self.speed = 0
                
                gameOverLabel.fontName = "Helvetica"
                gameOverLabel.fontSize = 30
                gameOverLabel.text = "Game Over! Tap to pay again."
                gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                self.addChild(gameOverLabel)
            }
        }
    }
}
