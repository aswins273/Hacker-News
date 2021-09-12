//
//  ViewController.swift
//  Hacker News
//
//  Created by S, Aswin (623-Extern) on 12/09/21.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet var newsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 75    }
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "newstableviewcell")) as?  NewsTableViewCell
        cell?.titleLabel.text = ""
        cell?.authorLabel.text = ""
        cell?.dateLabel.text = ""
        return cell!
    }
}
