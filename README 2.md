
It focuses on privacy (no network calls), responsiveness, and a simple MVVM architecture using Combine.

• Platform: iOS (Swift, SwiftUI, Combine)
• LLM backend: llama.cpp C API (via a Swift module import)
• Model format: GGUF (e.g., DeepSeek 7B Q4_K_M)
• Xcode: Built with modern Xcode and Swift toolchain

Why this project?

• 100% on‑device inference for private, offline usage
• Minimal Swift + C interop example for llama.cpp
• Clear, extensible architecture to add features like streaming, history, and model selection

How it works

• The app bundles a quantized GGUF model (e.g., deepseek-llm-7b-base.Q4_K_M.gguf) and loads it at startup.
• A simple ModelManager (ObservableObject) handles:
   • Loading the model via llama.cpp’s C API
   • Tokenizing input
   • Generating a response on a background queue
   • Publishing the response back to the UI via @Published

Key component

• ModelManager.swift􀰓
   • Initializes the llama model using llama_model_load_from_file(...)
   • Tokenizes input using llama_tokenize(...)
   • Generates a response asynchronously and publishes it via @Published var response

Example (simplified) usage in SwiftUI:
