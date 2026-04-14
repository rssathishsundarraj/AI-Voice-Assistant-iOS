//
//  SpeechToTextUseCaseImpl.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//
import Foundation

final class SpeechToTextUseCaseImpl: SpeechToTextUseCase {
    
    private let service: SpeechService
    
    init(service: SpeechService) {
        self.service = service
    }
    
    func startRecording() async throws -> String {
        let granted = await service.requestPermission()
        
        guard granted else {
            throw NSError(domain: "SpeechPermission", code: 1)
        }
        
        return try await service.startRecording()
    }
}
