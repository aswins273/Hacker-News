//
//  NewsDetailViewController.swift
//  Hacker News
//
//  Created by S, Aswin on 12/09/21.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var newsUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlStirng = newsUrl else { return }
        guard let url = URL(string: urlStirng) else { return  }
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
    }
}

extension NewsDetailViewController:  WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
