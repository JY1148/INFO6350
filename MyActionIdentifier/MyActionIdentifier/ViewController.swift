//
//  ViewController.swift
//  MyActionIdentifier
//
//  Created by Jinzhou Yan on 5/8/22.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    //0.4 create an instance of VideoCapture (check VideoCapture.swift)
    let videoCapture = VideoCapture()
    var previewLayer: AVCaptureVideoPreviewLayer?
    var pointsLayer = CAShapeLayer()
    var textLayer = CATextLayer()
    
    
    var isDetected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //0.1 build up func of setting up video preview
        setupVideoPreview()
        
        videoCapture.predictor.delegate = self
    }
    
    private func setupVideoPreview(){
        //0.5 start video capture
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        
        //0.2 initialize the previewLayer
        guard let previewLayer = previewLayer else {
            return
        }
        
        //0.3 set the frame
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        view.layer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.orange.cgColor
        
        view.layer.addSublayer(textLayer)
        textLayer.frame = view.frame
        textLayer.foregroundColor = UIColor.orange.cgColor
        print(view.bounds.height)
        print(view.bounds.width)
        textLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY+(view.bounds.height/2)-textLayer.fontSize)
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
    }
}

extension ViewController: PredictorDelegate{
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if(confidence > 0.95 && isDetected == false){
            isDetected = true
            switch action {
                case "Action_GolfSwing":
                    print("Action of GolfSwing Detected")
                    cleanUp()
                    DispatchQueue.main.async {
                        AudioServicesPlayAlertSound(SystemSoundID(1309))
                        self.textLayer.string = "Golf🏌️‍♂️(\(String(format: "%.1f", confidence*100))%)"
                    }
                case "Action_Archery":
                    print("Action of Archery Detected")
                    cleanUp()
                    DispatchQueue.main.async {
                        AudioServicesPlayAlertSound(SystemSoundID(1322))
                        self.textLayer.string = "Archery🏹(\(String(format: "%.1f", confidence*100))%)"
                    }
                case "Action_JumpRope":
                    print("Action of JumpRope Detected")
                    cleanUp()
                    DispatchQueue.main.async {
                        AudioServicesPlayAlertSound(SystemSoundID(1323))
                        self.textLayer.string = "JumpRope⬆️(\(String(format: "%.1f", confidence*100))%)"
                    }
                default:
                    print("Action detecting...")
            }
        }
    }
    func cleanUp(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.isDetected = false
            self.textLayer.string = ""
        }
    }
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = previewLayer else { return }
        
        let convertedPoints = points.map{
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        let combinedPath = CGMutablePath()
        
        for point in convertedPoints {
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinedPath.addPath(dotPath.cgPath)
        }
        
        pointsLayer.path = combinedPath
        
        DispatchQueue.main.async {
            self.pointsLayer.didChangeValue(for: \.path)
        }
    }
    
    
}

