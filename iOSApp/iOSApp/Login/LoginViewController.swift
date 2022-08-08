//
//  LoginViewController.swift
//  iOSApp

//  Created by thanh nguyen trong on 08/08/2022.
//


import UIKit
import WebKit

class LoginViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Constants
    private let CLIENT_ID = "b2c3a62f52dcc52a0152"
    private let CLIENT_SECRET = "eb94ef0cfb57fc2b0064e7c83f64dc3e4ca13224"
    private let REDIRECT_URI = "https://nextbestsolution.com/"
    private let SCOPE = "read:user,user:email"
    private let TOKENURL = "https://github.com/login/oauth/access_token"
    
    //MARK:- Properties / Variables
    fileprivate var viewModel: LoginViewModelInput?
    fileprivate let defaults = UserDefaults.standard
    fileprivate var webView = WKWebView()

    //MARK: Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 8
        viewModel?.viewDidLoad()
    }
    
    @IBAction func onLoginAction(_ sender: Any) {
        let githubVC = UIViewController()
        let uuid = UUID().uuidString
        webView.navigationDelegate = self
        githubVC.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: githubVC.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: githubVC.view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: githubVC.view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: githubVC.view.trailingAnchor)
        ])

        let authURLFull = "https://github.com/login/oauth/authorize?client_id=" + CLIENT_ID + "&scope=" + SCOPE + "&redirect_uri=" + REDIRECT_URI + "&state=" + uuid

        let urlRequest = URLRequest(url: URL(string: authURLFull)!)
        webView.load(urlRequest)

        let navController = UINavigationController(rootViewController: githubVC)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.onCancel))
        githubVC.navigationItem.leftBarButtonItem = cancelButton
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.onRefresh))
        githubVC.navigationItem.rightBarButtonItem = refreshButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navController.navigationBar.titleTextAttributes = textAttributes
        githubVC.navigationItem.title = "github.com"
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.white
        navController.navigationBar.barTintColor = UIColor.black
        navController.modalTransitionStyle = .coverVertical

        self.present(navController, animated: true, completion: nil)
    }
    
    func requestForCallbackURL(request: URLRequest) {
        let requestURLString = (request.url?.absoluteString)! as String
        print("requestForCallbackURL: \(requestURLString)")
        if requestURLString.hasPrefix(REDIRECT_URI) {
            if requestURLString.contains("code=") {
                if let range = requestURLString.range(of: "=") {
                    let githubCode = requestURLString[range.upperBound...]
                    if let range = githubCode.range(of: "&state=") {
                        let githubCodeFinal = githubCode[..<range.lowerBound]
                        githubRequestForAccessToken(authCode: String(githubCodeFinal))
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }

    func githubRequestForAccessToken(authCode: String) {
        let grantType = "authorization_code"

        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: URL(string: TOKENURL)!)
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
                self?.defaults.set(accessToken, forKey: LocalStorageKey.access_token)
            }
        }
        
        task.resume()
    }
    
    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onRefresh() {
        self.webView.reload()
    }
}

extension LoginViewController: LoginViewModelOutput {
    
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        requestForCallbackURL(request: navigationAction.request)
        decisionHandler(.allow)
    }
}

extension LoginViewController {
    class func createViewController() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return nil
        }
        
        let viewModel = LoginViewModel()
        viewModel.output = viewController
        viewController.viewModel = viewModel
        
        return viewController
    }
}
