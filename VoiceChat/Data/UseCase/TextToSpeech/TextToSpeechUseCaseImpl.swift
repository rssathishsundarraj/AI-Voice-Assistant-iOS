//
//  TextToSpeechUseCaseImpl.swift
//  VoiceChat
//
//  Created by Sathish Kumar RS on 14/04/26.
//

final class TextToSpeechUseCaseImpl: TextToSpeechUseCase {
    
    private let service: SpeechSynthesizerService
    
    init(service: SpeechSynthesizerService) {
        self.service = service
    }
    
    func speak(text: String) {
        service.speak(text: text)
    }
}
