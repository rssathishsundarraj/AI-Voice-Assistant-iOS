//
//  GeminiResponse.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

struct GeminiResponse: Decodable {
    let candidates: [Candidate]
}

struct Candidate: Decodable {
    let content: Content
}

struct Content: Decodable {
    let parts: [Part]
}

struct Part: Decodable {
    let text: String
}
