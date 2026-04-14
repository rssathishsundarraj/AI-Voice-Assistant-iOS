//
//  SpeechService.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

import Foundation
import Speech
import AVFoundation

final class SpeechService {
    
    private let recognizer = SFSpeechRecognizer()
    private let audioEngine = AVAudioEngine()
    
    // MARK: - Permission
    
    func requestPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
    
    // MARK: - Recording
    
    func startRecording() async throws -> String {
        
        // Reset engine
        audioEngine.stop()
        audioEngine.reset()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        guard let recognizer = recognizer, recognizer.isAvailable else {
            throw NSError(domain: "SpeechRecognizer", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Speech recognizer not available"
            ])
        }
        
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        
        // Validate format
        guard format.sampleRate > 0,
              format.channelCount > 0 else {
            throw NSError(domain: "AudioFormat", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Invalid audio format. Use real device."
            ])
        }
        
        // Remove previous tap
        inputNode.removeTap(onBus: 0)
        
        inputNode.installTap(onBus: 0,
                             bufferSize: 1024,
                             format: format) { buffer, _ in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        return try await withCheckedThrowingContinuation { continuation in
            
            var hasResumed = false
            var latestText = ""
            var silenceWorkItem: DispatchWorkItem?
            
            Task {
                try await Task.sleep(nanoseconds: 6_000_000_000)
                
                if !hasResumed {
                    hasResumed = true
                    
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    continuation.resume(throwing: NSError(
                        domain: "SpeechTimeout",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "No speech detected"]
                    ))
                }
            }
            
            recognizer.recognitionTask(with: request) { result, error in
                
                if let result = result {
                    let text = result.bestTranscription.formattedString
                    latestText = text
                    
                    // Cancel previous silence timer
                    silenceWorkItem?.cancel()
                    
                    // Create new silence timer
                    let workItem = DispatchWorkItem {
                        if !hasResumed {
                            hasResumed = true
                            
                            self.audioEngine.stop()
                            inputNode.removeTap(onBus: 0)
                            
                            continuation.resume(returning: latestText)
                        }
                    }
                    
                    silenceWorkItem = workItem
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: workItem)
                }
                
                if let error = error, !hasResumed {
                    hasResumed = true
                    
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
