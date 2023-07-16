//
//  HomeViewController+Datasource.swift
//  desafio
//
//  Created by Andre Dias on 16/07/23.
//
import UIKit

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCell", for: indexPath) as! ComicCell

        let comic = self.list[indexPath.row]
        cell.updateModel(item: comic)
        return cell
    }
}


