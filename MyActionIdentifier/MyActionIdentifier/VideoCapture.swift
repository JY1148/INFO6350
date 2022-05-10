//
//  VideoCapture.swift
//  MyActionIdentifier
//
//  Created by Jinzhou Yan on 5/8/22.
//

import Foundation
import AVFoundation

//initialize the VideoCapture class
class VideoCapture: NSObject{
    //1.1 create an instance of AVCaptureSession
    let captureSession = AVCaptureSession()
    //1.6 create an instance of video output
    let videoOutput = AVCaptureVideoDataOutput()
    
    let predictor = Predictor()
    
    override init(){
        super.init()
        //1.2 define the default camera as the captureDevice
        guard let captureDevice = AVCaptureDevice.default(for: .video),
              //1.3 define the input as the captureDevice input
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        
        //set high bit rate ( which is also the default)
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        captureSession.addInput(input)
        
        // 1.7 add output of the camera capture
        captureSession.addOutput(videoOutput)
        // 1.8 discard if the data output queue is blocked
        videoOutput.alwaysDiscardsLateVideoFrames = true
    }
    
    //1.5 set the start function
    func startCaptureSession(){
        captureSession.startRunning()
        // get the video output data and set the dispatch queue
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoDispatchQueue"))
    }
}

extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}
