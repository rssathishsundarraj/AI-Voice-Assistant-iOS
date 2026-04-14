//
//  SpeechSynthesizerService.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

import AVFoundation

final class SpeechSynthesizerService {
    
    private let synthesizer = AVSpeechSynthesizer()
    
    init() {
        configureAudioSession()
    }
    
    func speak(text: String) {
        
        guard !text.isEmpty else { return }
        
        // Stop previous speech
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        utterance.rate = 0.42
        utterance.pitchMultiplier = 1.1
        utterance.volume = 1.0
        
        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(
                .playAndRecord,
                mode: .default,
                options: [
                    .defaultToSpeaker,
                    .duckOthers
                ]
            )
            
            try session.setActive(true)
            
        } catch {
            print("Audio session error:", error)
        }
    }
}
