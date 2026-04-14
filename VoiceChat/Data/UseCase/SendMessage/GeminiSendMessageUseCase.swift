//
//  GeminiSendMessageUseCase.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//
import Foundation

final class GeminiSendMessageUseCase: SendMessageUseCase {
    
    private let service: GeminiService
    
    init(service: GeminiService) {
        self.service = service
    }
    
    func execute(input: String) async throws -> ChatMessage {
        let text = try await service.sendMessage(input)
        
        return ChatMessage(
            text: text.trimmingCharacters(in: .whitespacesAndNewlines),
            isUser: false
        )
    }
}
