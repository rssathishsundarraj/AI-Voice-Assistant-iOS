//
//  ChatView.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//
import SwiftUI

struct ChatView: View {
    
    @State private var viewModel: ChatViewModel
    
    // MARK: - Init (Dependency Injection)
    init() {
        let speechService = SpeechService()
        let ttsService = SpeechSynthesizerService()
        let aiService = GeminiService()
        
        _viewModel = State(
            initialValue: ChatViewModel(
                sendMessageUseCase: GeminiSendMessageUseCase(service: aiService),
                speechUseCase: SpeechToTextUseCaseImpl(service: speechService),
                ttsUseCase: TextToSpeechUseCaseImpl(service: ttsService)
            )
        )
    }
    
    var body: some View {
        VStack {
            
            // MARK: - Messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            messageRow(message)
                                .id(message.id)
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) {
                    if let last = viewModel.messages.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }
            
            Divider()
            
            // MARK: - Input Bar
            HStack {
                TextField("Type message...", text: $viewModel.inputText)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    viewModel.startVoiceInput()
                } label: {
                    Image(systemName: viewModel.isRecording ? "mic.fill" : "mic")
                        .foregroundColor(viewModel.isRecording ? .red : .blue)
                }
                
                // Send Button
                Button("Send") {
                    viewModel.sendMessage()
                }
                .disabled(viewModel.inputText.isEmpty)
            }
            .padding()
        }
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
    
    // MARK: - Message Bubble
    @ViewBuilder
    private func messageRow(_ message: ChatMessage) -> some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}
