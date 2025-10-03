//
//  ModelManager.swift
//  DFSVOneChat
//
//  Created by Admin on 13/09/25.
//

import Foundation
import Combine
import llama

class ModelManager: ObservableObject {
    @Published var response: String = ""
    private var model: OpaquePointer?

    init() {
        loadModel()
    }

    func loadModel() {
        let modelPath = Bundle.main.path(forResource: "deepseek-llm-7b-base.Q4_K_M", ofType: "gguf")!
       
//        params.some_parameter = some_value; // Set the required parameters
        // Initialize other parameters as needed

        model = llama_model_load_from_file(modelPath, llama_model_default_params())
//        model = llama_load_model(modelPath)
    }

    func generateResponse(prompt: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let response = self.runModel(prompt: prompt)
            DispatchQueue.main.async {
                self.response = response
            }
        }
    }

    private func runModel(prompt: String) -> String {
        guard let model = model else { return "Model not loaded" }
        let maxTokens: Int32 = 100
        let textCString = prompt.cString(using: .utf8)
        let textLen = Int32(textCString?.count ?? 0 - 1)
        var tokens = [llama_token](repeating: 0, count: Int(maxTokens))
        let numtokens = llama_tokenize(model,  textCString?.withUnsafeBytes { $0.baseAddress!.assumingMemoryBound(to: CChar.self) }, textLen, &tokens, maxTokens, true, true)
        
        let response = llama_generate(model, numtokens)
        return response
    }
}
