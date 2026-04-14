//
//  GeminiService.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

import Foundation

final class GeminiService {
    
    private let apiKey = "YOUR_API_KEY"
    
    func sendMessage(_ text: String) async throws -> String {
        let urlString = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": text]
                    ]
                ]
            ]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
                
        let response = try JSONDecoder().decode(GeminiResponse.self, from: data)
        
        return response.candidates.first?.content.parts.first?.text ?? "No response"
    }
}
