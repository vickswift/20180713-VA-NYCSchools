//
//  WebViewController.swift
//  20180713-VA-NYCSchools
//
//  Created by Victor  Adu on 7/13/18.
//  Copyright © 2018 Filmic. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    
    var applicationURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Webview tasks
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.frame, configuration: webConfiguration)
        webView.isUserInteractionEnabled = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        webView.addSubview(activityIndicator)
        
        if let url = URL(string: applicationURL) {
            let request = URLRequest.init(url: url)
            webView.load(request)
        }
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
    //MARK: - WKNavigationDelegate Methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
