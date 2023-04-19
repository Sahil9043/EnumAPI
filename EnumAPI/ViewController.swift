//
//  ViewController.swift
//  ApiThree
//
//  Created by Lalaiya Sahil on 03/02/23.
//

import UIKit

class ViewController: UIViewController {
    var arrUser: [UserInfo] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }

    private func getUser(){
        guard let url = URL(string: "https://gorest.co.in/public/v2/users/667/posts") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let apiData = data else {return}
            do{
                let user = try JSONDecoder().decode(UserInfo.self, from: apiData)
            }catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }

}

struct UserInfo: Decodable{
    var id: Int
    var UserId: Int
    var title: String
    var body: String
    
    private enum CodingKeys: String, CodingKey{
        case id,title,body
        case UserId = "user_id"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        let user = arrUser[indexPath.row]
        cell.textLabel?.text = "\(user.body)"
        return cell
    }
}
