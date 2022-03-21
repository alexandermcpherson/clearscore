//
//  NetworkService.swift
//  ClearScore
//
//  Created by Alex McPherson on 08/03/2022.
//

import Foundation

enum NetworkError: String, Error {
    case EmptyUrl = "Empty URL"
    case NotConnectedToNetwork = "Not connected to network"
}

enum HTTPStatusCode: Int, Error {
    case Info = 100
    case Success = 200
    case Redirect = 300
    case Client = 400
    case Server = 500
    case Unknown = 999

    var description: String {
        switch self {
        case .Info:
            return "HTTP Info"
        case .Success:
            return "HTTP Success"
        case .Redirect:
            return "HTTP Redirect"
        case .Client:
            return "HTTP Client ERROR"
        case .Server:
            return "HTTP Server ERROR"
        case .Unknown:
            return "HTTP Unknown"
        }
    }

    init(code: Int) {
        switch code {
            case 100...199: self = .Info
            case 200...299: self = .Success
            case 300...399: self = .Redirect
            case 400...499: self = .Client
            case 500...599: self = .Server
            default: self = .Unknown
        }
    }
}

struct NetworkService {

    // MARK: - Properties
    var endpoint: String

    // MARK: - Methods
    func getData<T: Decodable>(object: T.Type, completion: @escaping (Bool, T?, Error?) -> Void) {

        guard endpoint != "" else {
            completion(false, nil, NetworkError.EmptyUrl)
            return
        }

        guard let url = URL(string: endpoint) else {
            fatalError("URL cannot be nil")
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }
            guard let httpResponse = response as? HTTPURLResponse else { return }

            if let error = error {
                print("Failed to get data:", error)
                completion(false, nil, error)
            }

            switch HTTPStatusCode(code: httpResponse.statusCode) {
            case .Info:
                completion(false, nil, HTTPStatusCode.Info)
            case .Success:
                print("HTTP Success")
                do {
                    let obj = try JSONDecoder().decode(T.self, from: data)
                    completion(true, obj, nil)
                } catch let jsonError {
                    print("Failed to decode json: ", jsonError)
                    completion(false, nil, jsonError)
                }
            case .Redirect:
                completion(false, nil, HTTPStatusCode.Redirect)
            case .Client:
                completion(false, nil, HTTPStatusCode.Client)
            case .Server:
                completion(false, nil, HTTPStatusCode.Server)
            case .Unknown:
                completion(false, nil, HTTPStatusCode.Unknown)
            }

        }.resume()
    }
}
