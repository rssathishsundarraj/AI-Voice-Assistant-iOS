//
//  SendMessageUseCase.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

protocol SendMessageUseCase {
    func execute(input: String) async throws -> ChatMessage
}
