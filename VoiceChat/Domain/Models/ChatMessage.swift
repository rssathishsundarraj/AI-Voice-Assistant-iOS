//
//  ChatMessage.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//
import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let text: String
    let isUser: Bool
    
    init(id: UUID = UUID(), text: String, isUser: Bool) {
        self.id = id
        self.text = text
        self.isUser = isUser
    }
}
