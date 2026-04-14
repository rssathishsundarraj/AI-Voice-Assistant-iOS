//
//  AIService.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

import Foundation

final class AIService {
    
    private let apiKey = "YOUR_API_KEY"
    
    func sendMessage(_ text: String) async throws -> String {
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "user", "content": text]
            ]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        
        return response.choices.first?.message.content ?? "No response"
    }
}
