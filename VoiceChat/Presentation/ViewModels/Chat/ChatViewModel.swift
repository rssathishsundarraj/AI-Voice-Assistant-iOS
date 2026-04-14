//
//  ChatViewModel.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

import Foundation

@MainActor
@Observable
final class ChatViewModel {
    
    // MARK: - State
    var messages: [ChatMessage] = []
    var inputText: String = ""
    var isLoading: Bool = false
    var isRecording: Bool = false
    var errorMessage: String?
    
    // MARK: - Dependencies
    private let sendMessageUseCase: SendMessageUseCase
    private let speechUseCase: SpeechToTextUseCase
    private let ttsUseCase: TextToSpeechUseCase
    
    // MARK: - Task Management
    private var currentTask: Task<Void, Never>?
    
    // MARK: - Init
    init(
        sendMessageUseCase: SendMessageUseCase,
        speechUseCase: SpeechToTextUseCase,
        ttsUseCase: TextToSpeechUseCase
    ) {
        self.sendMessageUseCase = sendMessageUseCase
        self.speechUseCase = speechUseCase
        self.ttsUseCase = ttsUseCase
    }
    
    // MARK: - Actions
    
    func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        let userMessage = ChatMessage(text: inputText, isUser: true)
        messages.append(userMessage)
        
        let input = inputText
        inputText = ""
        
        currentTask?.cancel()
        
        isLoading = true
        
        currentTask = Task {
            do {
                let response = try await sendMessageUseCase.execute(input: input)
                messages.append(response)
                
                // 🔊 Speak AI response
                ttsUseCase.speak(text: response.text)
                
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
    
    func startVoiceInput() {
        currentTask?.cancel()
        
        isRecording = true
        errorMessage = nil
        
        currentTask = Task {
            do {
                let text = try await speechUseCase.startRecording()
                inputText = text
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isRecording = false
        }
    }
}
