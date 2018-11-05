//
//  ViewController.swift
//  Measurefun
//
//  Created by Raúl Torres on 08/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    var firtsBox : SCNNode?
    var secondBox : SCNNode?
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var targetView: UIView!
    @IBOutlet var measurementLabel: UILabel!
    
    @IBOutlet var theButton: UIButton!
    
    @IBAction func theButtonAction(_ sender: Any) {
        
        if firtsBox == nil {
            firtsBox = addBox()
            if firtsBox != nil {
                theButton.setTitle("Set End Point", for: .normal)
            }
        } else if secondBox == nil {
            secondBox = addBox()
            //calculation
            if secondBox != nil {
                calcDistance()
                theButton.setTitle("Reset", for: .normal)
            }
        } else {
            //reset
            firtsBox?.removeFromParentNode()
            secondBox?.removeFromParentNode()
            firtsBox = nil
            secondBox = nil
            measurementLabel.text = ""
            theButton.setTitle("Set Start Point", for: .normal)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        measurementLabel.text = ""
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func addBox() -> SCNNode? {
        let userTouch = sceneView.center
        let testResults = sceneView.hitTest(userTouch, types: .featurePoint)
        
        if let result = testResults.first {
            let box = SCNBox(width: 0.005, height: 0.005, length: 0.005, chamferRadius: 0.005)
            let material = SCNMaterial()
            material.diffuse.contents = UIColor.green
            box.firstMaterial = material
            
            let boxNode = SCNNode(geometry: box)
            boxNode.position = SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
            
            sceneView.scene.rootNode.addChildNode(boxNode)
            return boxNode
        }
        return nil
    }
    
    func calcDistance() {
        if let fb = firtsBox, let sb = secondBox {
            let vector = SCNVector3Make(sb.position.x - fb.position.x, sb.position.y - fb.position.y, sb.position.z - fb.position.z)
            let distance = sqrt(vector.x*vector.x+vector.y*vector.y+vector.z*vector.z)
            measurementLabel.text = "\(distance)m"
        }
    }
    
    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
