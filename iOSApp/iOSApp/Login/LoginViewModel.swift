//
//  LoginViewModel.swift
//  iOSApp

//  Created by thanh nguyen trong on 08/08/2022.
//


import Foundation

protocol LoginViewModelInput: AnyObject {
    func viewDidLoad()
    func getAccessToken(authCode: String, clientId: String, clientSecret: String, baseUrl: String)
}

protocol LoginViewModelOutput: AnyObject {
    func didGetAccessToken(token: String?)
}


final class LoginViewModel {
    //MARK: - Instance properties
    weak var output: LoginViewModelOutput?
    
    //MARK: - Object lifecycle
    init() {
        
    }
    
    deinit {
        print("LoginViewModel deinit")
    }
}

//MARK: - Input
extension LoginViewModel: LoginViewModelInput {
    func getAccessToken(authCode: String, clientId: String, clientSecret: String, baseUrl: String) {
        let grantType = "authorization_code"

        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + clientId + "&client_secret=" + clientSecret
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: URL(string: baseUrl)!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { [weak self] (data, response, _) -> Void in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                let accessToken = results?["access_token"] as? String
                print("GitHub Access Token: \(accessToken ?? "")")
                self?.output?.didGetAccessToken(token: accessToken)
            }
        }
        
        task.resume()
    }
    
    func viewDidLoad() {
        print("LoginViewModel viewDidLoad")
    }
}
