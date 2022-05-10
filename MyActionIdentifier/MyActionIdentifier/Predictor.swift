//
//  Predictor.swift
//  MyActionIdentifier
//
//  Created by Jinzhou Yan on 5/8/22.
//

import Foundation
import Vision

typealias ActionIdentifier = ActCat_AGJ_1

protocol PredictorDelegate: AnyObject {
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double)
}

class Predictor {
    weak var delegate: PredictorDelegate?
    //3.1 add prediction window and set the fps size
    let predictionWindowSize = 60
    var posesWindow: [VNHumanBodyPoseObservation] = []
    
    //3.2 init the posesWindow: set the length
    init(){
        posesWindow.reserveCapacity(predictionWindowSize)
    }
    
    func estimation(sampleBuffer: CMSampleBuffer){
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request, with error: \(error)")
        }
    }
    
    func bodyPoseHandler(request: VNRequest, error: Error?){
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else { return }
        observations.forEach {
            processObservation($0)
        }
        //3.3 store the observation
        if let result = observations.first{
            storeObservation(result)
            //3.5 initialize and analyze
            labelActionType()
        }
    }
    
    func labelActionType(){
        //3.5 initialize 1. the ML model 2. to identify the actions 3. prediction result
        guard let actionClassifier = try? ActionIdentifier(configuration: MLModelConfiguration())else {
            return
        }
        guard let poseMultiArray = prepareInputWithObservations(posesWindow) else {
            return
        }
        guard let predictions = try? actionClassifier.prediction(poses: poseMultiArray) else {
            return
        }
        let label = predictions.label
        let confidence = predictions.labelProbabilities[label] ?? 0
        
        delegate?.predictor(self, didLabelAction: label, with: confidence)
    }
    
    //3.6 prepareInputWithObservations
    func prepareInputWithObservations(_ observations: [VNHumanBodyPoseObservation]) -> MLMultiArray? {
        let numAvailableFrames = observations.count
        let observationsNeeded = predictionWindowSize
        var multiArrayBuffer = [MLMultiArray]()
        
        for frameIndex in 0 ..< min(numAvailableFrames, observationsNeeded){
            let pose = observations[frameIndex]
            do {
                let oneFrameMultiArray = try pose.keypointsMultiArray()
                multiArrayBuffer.append(oneFrameMultiArray)
            } catch {
                continue
            }
        }
        
        if numAvailableFrames < observationsNeeded {
            for _ in 0 ..< (observationsNeeded-numAvailableFrames){
                do {
                    let oneFrameMultiArray = try MLMultiArray(shape: [1, 3, 18], dataType: .double)
                    try resetMultiArray(oneFrameMultiArray)
                    multiArrayBuffer.append(oneFrameMultiArray)
                } catch {
                    continue
                }
            }
        }
        
        return MLMultiArray(concatenating: [MLMultiArray](multiArrayBuffer), axis: 0, dataType: .float)
    }
    
    func resetMultiArray(_ predictionWindow: MLMultiArray, with value: Double = 0.0) throws {
        let pointer = try UnsafeMutableBufferPointer<Double>(predictionWindow)
        pointer.initialize(repeating: value)
    }
    func storeObservation(_ observation: VNHumanBodyPoseObservation){
        //3.4 add into posesWindow (always use 30 frames)
        if posesWindow.count >= predictionWindowSize {
            posesWindow.removeFirst()
        }
        posesWindow.append(observation)
    }
    
    func processObservation(_ observation: VNHumanBodyPoseObservation){
        do {
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)
            let displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.value.x, y: 1 - $0.value.y)
            }
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
        } catch {
            print("error finding recognized points")
        }
    }
}
