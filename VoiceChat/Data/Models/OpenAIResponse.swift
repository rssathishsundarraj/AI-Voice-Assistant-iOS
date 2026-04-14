//
//  OpenAIResponse.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

struct OpenAIResponse: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let message: Message
}

struct Message: Decodable {
    let content: String
}
