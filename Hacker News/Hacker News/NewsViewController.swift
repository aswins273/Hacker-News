//
//  ViewController.swift
//  Hacker News
//
//  Created by S, Aswin (623-Extern) on 12/09/21.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet var newsTableView: UITableView!
    var newsDetails = [NewsContent]()
    var searchText : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsDetails()
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 75
    }
}

// MARK: Tableview Datasource Methods
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "newstableviewcell")) as?  NewsTableViewCell
        let news = newsDetails[indexPath.row]
        if let title = news.title, title != "" {
            cell?.titleLabel.text = title
        }
        if let author = news.author {
            cell?.authorLabel.text = "by \(author)"
        }
        if let timeResult = (news.created_at_i) {
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            cell?.dateLabel.text = localDate
        }
        return cell!
    }
}

// MARK: SearchBar Delegate Methods
extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "", query.count >= 3 else {
            searchText = nil
            getNewsDetails()
            return
        }
        searchText = query
        getNewsDetails()
    }
}
//MARK: News api call
extension NewsViewController {
    func getNewsDetails() {
        let session = URLSession.shared
        var urlString = "https://hn.algolia.com/api/v1/search?"
        if let text = searchText {
            urlString += "query=\(text)"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if let statusCode = httpResponse?.statusCode {
                if (statusCode == 200) {
                    self?.parseData(data!)
                }
            }
            if let errorStatus = error {
                print(errorStatus)
            }
        }
        task.resume()
    }
    func parseData(_ data : Data){
        do{
            let decoder = JSONDecoder()
            let response = try decoder.decode(News.self, from: data)
            newsDetails.removeAll()
            newsDetails = response.hits
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.newsTableView.reloadData()
            }
        }
        catch{
            print(error)
        }
    }
}
