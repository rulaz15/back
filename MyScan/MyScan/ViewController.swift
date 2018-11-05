//
//  ViewController.swift
//  MyScan
//
//  Created by Raúl Torres on 16/08/18.
//  Copyright © 2018 ISA. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScanDelegate {
    func addScan(code: String, type: String)
}

class ViewController: UIViewController {

    var scanDelegate : ScanDelegate!
    var captureSession : AVCaptureSession!
    var previewLayer : AVCaptureVideoPreviewLayer!

    let btn : UIButton = {
        let button = UIButton()
        button.setTitle("☃️🦖", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9131130642, green: 0, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(startScanAgain(sender:)), for: .touchUpInside)
        return button
    }()
    
//    let resultLabel : UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.numberOfLines = 0
//        return label
//    }()
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .black
        
        self.view.addSubview(btn)
        
//        self.view.addSubview(resultLabel)

        let xConstraint = NSLayoutConstraint(item: btn, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: btn, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 50)

        btn.translatesAutoresizingMaskIntoConstraints = false

        self.view.addConstraints([xConstraint,yConstraint])
       
//        view.addContraintsWithFormat("H:[v0]", views: resultLabel)
//        view.addContraintsWithFormat("V:[v0]-20-[v1]", views: btn, resultLabel)
        

        captureSession = AVCaptureSession()
        

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput : AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
//            [.ean8, .ean13, .pdf417, .qr, .code39, .code128, .interleaved2of5, .upce, .pdf417, .dataMatrix, .aztec, .itf14]
            //https://barcode-labels.com/getting-started/barcodes/types/
            
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height) // CGRect(x: 0, y: 0, width: self.view.bounds.width , height: self.view.bounds.height / 2)
        previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(previewLayer)
        
        let lineView = UIView(frame: CGRect(x: 0, y: previewLayer.bounds.midY, width: self.view.bounds.width, height: 1))
        lineView.backgroundColor = .red
        self.view.addSubview(lineView)
        
        captureSession.startRunning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    private func failed() {
        let alertC = UIAlertController(title: "scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        alertC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertC, animated: true, completion: nil)
        captureSession = nil
    }

    private func found(code: String, type: String) {
        print(code + "\ntype: " + type)
    }
    
    @objc func startScanAgain(sender: UIButton){
        
        captureSession.startRunning()
    }
}

//MARK: - CAPTURE METADATA DELEGATE
extension ViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {

            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }

            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue, type: metadataObject.type.rawValue)
            scanDelegate.addScan(code: stringValue, type: metadataObject.type.rawValue)
        }
//        previewLayer.removeFromSuperlayer()
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
