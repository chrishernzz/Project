//
//  ViewController.swift
//  Project
//
//  Created by Isaiah Vogt on 11/6/24.
//

import Foundation /* URLSession */

/* * * * * * * * * * * * * Routes * * * * * * * * * * * * * */
/* Create User */

/* Login */

/* Add product to ShoppingCart */

/* Get User ShoppingCart */

/* Send Inquiry */

/* Submit Order */

/* Get an order */



/* * * * * * * * * * * * * Fetch * * * * * * * * * * * * * */

/* This formats each API Request, sends it to the server, and responds to the call. */
class ClientServer {
    
    static let shared = ClientServer()
    private init() {} // Prevents others from creating another instance
        
    
    /* Request/Response functionality */
    func testLoad(url: String, method: String = "GET", payload: Any? = nil) {
        /* This is the base url that will be routed to. */
        guard let fullUrl = URL(string: "http://localhost:8080\(url)") else {
                print("Invalid URL")
                return
            }
        
        /* Call sendRequest to put together the url, method, and payload */
        sendRequest(url: fullUrl, method: method, payload: payload) { result in
            switch result {
            case .success(let responseString):
                /* TODO: Change this to not just print */
                print("JSON Content: \(responseString)")
            case .failure(let error):
                self.handleClientError(error)
            }
        }
    }

    /* Network Request */
    /* completion is a completion handler or closure that gets called when the async operation completes. @escaping means the function can be called asyncronously and it returns a closure that is either a String(success) or Error(Failure).
     */
    private func sendRequest(url: URL, method: String = "GET", payload: Any? = nil, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: url)
        
        /* GET, PUT, POST, DELETE */
        request.httpMethod = method

        /* TODO: Do I need to check for both? Presumably there is only one payload type/struct. */
        /* Here we aim to populate request with the formData. */
        if let payload = payload {
            /* payload is formData */
            if let formData = payload as? Data {
                request.httpBody = formData
            } else {
                /* payload is JSON */
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                if let jsonData = try? JSONSerialization.data(withJSONObject: payload) {
                    request.httpBody = jsonData
                } else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON payload"])))
                    return
                }
            }
        }
        
        /* task is a data task which fetches from the URL */
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            /* Guarantees 200 level request, creates data variable to hold data from request. */
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let mimeType = httpResponse.mimeType, mimeType == "application/json",
                  let data = data else {
                self.handleServerError(response)
                return
            }
            
            /* Success string */
            if let htmlString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completion(.success(htmlString))
                }
            } else {
                /* Eroror */
                let error = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response as a string"])
                completion(.failure(error))
            }
        }
        task.resume()
    }

    /* Error handlers */
    private func handleClientError(_ error: Error) {
        print("Client Error: \(error)")
    }

    private func handleServerError(_ response: URLResponse?) {
        print("Server error \(String(describing: response))")
    }
}
