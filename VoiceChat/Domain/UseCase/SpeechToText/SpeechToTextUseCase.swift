//
//  SpeechToTextUseCase.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

protocol SpeechToTextUseCase {
    func startRecording() async throws -> String
}
