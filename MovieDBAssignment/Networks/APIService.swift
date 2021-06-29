//
//  APIService.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import Foundation

enum RespResult <T>{
    case Success(T)
    case Error(String)
}

typealias handler<Model:Codable> = (_ model:Model?,_ message:String?)->()

public class APIService: NSObject {
    func startService<Model:Codable>(with path:String, parameters:Dictionary<String,Any>?, model:Model.Type, completion: @escaping (RespResult<Any?>) -> Void){
        
        
        guard let url = URL(string:URLs.baseUrl + path) else {
            return completion(.Error(StringConstant.invalidUrl))
        }
        print(url)
        print(parameters as Any)
        let request = self.buildRequest(with: url, parameters: parameters)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else {
                return completion(.Error(error?.localizedDescription ?? "Data not found."))
            }
            let (decodedData,message) = self.decodeData(data: data, model: model)
            (decodedData != nil) ? completion(.Success(decodedData)) : completion(.Error(message ?? ""))
        }
        task.resume()
    }
    
    func buildRequest(with url:URL,parameters:Dictionary<String,Any>?) -> URLRequest {
        var request:URLRequest? = nil
        if let params = parameters,params.count > 0 {
            var baseAppend = url.appendingPathComponent("?"+buildParams(parameters: params)).absoluteString.removingPercentEncoding
            baseAppend = baseAppend?.replacingOccurrences(of: "/?", with: "?")
                let baseUrl = URL(string: baseAppend ?? "")!
            request = URLRequest(url: baseUrl)
        } else {
            request = URLRequest(url: url)
        }
        request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var req = request ?? URLRequest(url: url)
        req.httpMethod = "GET"
        
        return req
    }
    
    func buildParams(parameters: Dictionary<String,Any>) -> String {
        var components: [(String, String)] = []
        for (key,value) in parameters {
            components += self.queryComponents(key, value)
        }
        return (components.map{"\($0)=\($1)"} as [String]).joined(separator: "&")
    }
    
    func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? Dictionary<String,Any> {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.append(contentsOf: [(escape(string: key), escape(string: "\(value)"))])
        }
        return components
    }
    
    func escape(string: String) -> String {
        if let encodedString = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            return encodedString
        }
        return ""
    }
    
    
    //Decode Data into the required Model
    func decodeData<Model:Codable>(data: Data?, model: Model.Type) -> (Model?,String?) {
        guard let responseData = data else {
            return (nil,nil)
        }
        do {
            
            let apiResponse = try JSONDecoder().decode(Model.self, from: responseData)
            return (apiResponse,nil)
        }catch {
            print(error)
            return (nil,error.localizedDescription)
        }
    }
    
}

