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
    var newsUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlStirng = newsUrl else { return }
        guard let url = URL(string: urlStirng) else { return  }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
