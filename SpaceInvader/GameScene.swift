//
//  GameScene.swift
//  SpaceInvader
//
//  Created by student5 on 5/23/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var plane = SKSpriteNode()
    
    
    
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var moved: SKSpriteNode!
    
    var touchPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var touchingScreen = false
    
    override func didMove(to view: SKView) {
        plane.childNode(withName: "spaceShip")
        leftButton = SKSpriteNode(imageNamed: "leftArrow")
        rightButton = SKSpriteNode(imageNamed: "rightArrow")
        
        leftButton.size = CGSize(width: 50, height: 50)
        rightButton.size = CGSize(width: 50, height: 50)
      
        
        leftButton.position = CGPoint(x: 500, y: 100)
        addChild(leftButton)
        rightButton.position = CGPoint(x: 575, y: 100)
        addChild(rightButton)
        moved = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 50.0, height: 50.0))
        moved.position = CGPoint(x: 150.0, y: 75.0)
        addChild(moved)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let point = touch.location(in: self)
        
        touchPoint = point
        touchingScreen = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchingScreen = false
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        if touchingScreen {
            let objects = nodes(at: touchPoint)
            if objects.contains(rightButton){
                // move character to the right.
                rightButton.color = UIColor.green
                let moveTOLeft = SKAction.moveBy(x: 10, y: 0, duration: 0.00000001)
                moved.run(moveTOLeft)
            }
            else if objects.contains(leftButton) {
                // move character to the left.
                leftButton.color = UIColor.green
                let moveTOLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.00000001)
                moved.run(moveTOLeft)
            }
        }
        else { // if no touches.
            // move character back to middle of screen. Or just do nothing.
            rightButton.color = UIColor.red
            leftButton.color = UIColor.red
        }
    }
}
