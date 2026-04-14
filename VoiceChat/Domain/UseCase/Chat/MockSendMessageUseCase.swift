//
//  MockSendMessageUseCase.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

final class MockSendMessageUseCase: SendMessageUseCase {
    
    func execute(input: String) async throws -> ChatMessage {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return ChatMessage(
            text: "AI: \(input)",
            isUser: false
        )
    }
}
