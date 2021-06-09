//
//  NetworkController.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/7/21.
//

import Foundation

class NetworkController {
    static let `default` = NetworkController()
    let serverDefinition: ServerDefinition
    let session: URLSession

    init(_ serverDefinition: ServerDefinition = DataServerDefinition()) {
        self.serverDefinition = serverDefinition
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }

    func executeGetRequest<ResultType: Decodable,
                           Parameters: Encodable>(route: HTTPRoute,
                                         parameters: Parameters?,
                                         headers: RequestHeaders? = nil,
                                         completion: @escaping (Swift.Result<ResultType, Error>) -> Void) {
        do {
            let request = try buildRequest(route: route,
                                           parameters: parameters,
                                           headers: headers)
            execute(request) { (result: Swift.Result<ResultType, Error>) in
                switch result {
                case .success(let result):
                    DispatchQueue.main.async {completion(.success(result))}
                case .failure(let error):
                    DispatchQueue.main.async {completion(.failure(error))}
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    private func buildRequest(route: HTTPRoute, parameters: Encodable, headers: RequestHeaders?) throws -> URLRequest {
        guard let url = URL(string: serverDefinition.baseServerURL + route.path) else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue

        headers?.forEach({ header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        })

        let parametersDict = try parameters.asDictionary()
        if route.method == .get {
            var components = URLComponents()
            components.scheme = serverDefinition.serverScheme
            components.host = serverDefinition.baseServerURL
            components.path = "/\(route.path)"
            components.queryItems = parametersDict.compactMap({ entry in
                guard let value = entry.value as? String else {return nil}
                return URLQueryItem(name: entry.key, value: value)
            })
            request.url = components.url
        }
        return request
    }

    private func execute<T: Decodable>(_ request: URLRequest,
                                       completion: @escaping(Result<T, Error>) -> Void) {
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.responseError))
                return
            }
            switch response.statusCode {
            case 200...299:
                if let data = data {
                    self?.parseData(data, completion: completion)
                } else {
                    completion(.failure(NetworkError.responseError))
                }
            default:
                completion(.failure(NetworkError.responseError))
            }
        }.resume()
    }

    func parseData<ResultType:Decodable>(_ data: Data,
                                         completion: @escaping (Result<ResultType, Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            let result = try decoder.decode(ResultType.self, from: data)
            completion(.success(result))
        } catch let error {
            completion(.failure(error))
        }
    }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
