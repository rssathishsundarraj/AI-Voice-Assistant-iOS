//
//  RealSendMessageUseCase.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//
import Foundation

final class RealSendMessageUseCase: SendMessageUseCase {
    
    private let service: AIService
    
    init(service: AIService) {
        self.service = service
    }
    
    func execute(input: String) async throws -> ChatMessage {
        
        // Call API
        let responseText = try await service.sendMessage(input)
        
        // Map to Domain model
        return ChatMessage(
            text: responseText.trimmingCharacters(in: .whitespacesAndNewlines),
            isUser: false
        )
    }
}
