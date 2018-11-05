//
//  ViewController.swift
//  CustomCamera
//
//  Created by Raúl Torres on 16/11/17.
//  Copyright © 2017 ISA. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var captureSession = AVCaptureSession()
    
    var backCamera : AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    @IBOutlet weak var cameraView: UIView!
    @IBAction func cameraBtnAction(_ sender: Any) {
        
        let setting = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: setting, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupCaptureSession(){
        
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice(){
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            
            if device.position == .back{
                
                backCamera = device
            } else if device.position == .front {
                
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput(){
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setupPreviewLayer(){
        
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = .portrait
        cameraPreviewLayer?.frame = self.cameraView.bounds
        self.cameraView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
        //cameraPreviewLayer?.frame = self.view.bounds
        //self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession(){
        
        captureSession.startRunning()
    }
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        
        if let imageData = photo.fileDataRepresentation(){
            print(imageData)
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhotoSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoSegue" {
            
            let previewVC = segue.destination as! PreviewViewController
            previewVC.image = self.image
        }
    }
}

