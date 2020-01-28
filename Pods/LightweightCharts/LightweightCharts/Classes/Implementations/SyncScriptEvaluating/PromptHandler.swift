import Foundation
import WebKit

protocol ClosuresStore: class {
        
    func addMethod<T>(_ method: JavaScriptMethod<T>, forName name: String)
    
}

// MARK: -
class PromptHandler: NSObject, ClosuresStore {
   
    private let decoder = JSONDecoder()

    private var closures: [String: JavaScriptSyncMethod] = [:]
    
    func addMethod<T>(_ method: JavaScriptMethod<T>, forName name: String) where T: Decodable {
        switch method {
        case .closure:
            closures[name] = method
        case .javaScript:
            break
        }
    }
    
}

// MARK: - WKUIDelegate
extension PromptHandler: WKUIDelegate {
    
    struct Payload: Decodable {
        let object: String
    }
    
    func webView(
        _ webView: WKWebView,
        runJavaScriptTextInputPanelWithPrompt prompt: String,
        defaultText: String?,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping (String?) -> Void) {
        
        if let payloadData = prompt.data(using: .utf8, allowLossyConversion: false),
            let payload = try? decoder.decode(Payload.self, from: payloadData) {
            let result = closures[payload.object]?.evaluate(payloadData: payloadData, with: decoder)
            completionHandler(result)
        } else {
            completionHandler(defaultText)
        }
    }
    
}
