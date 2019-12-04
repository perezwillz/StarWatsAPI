//
//  JediViewController.swift
//  StarWarsCodeChallenge
//
//  Created by Perez Willie Nwobu on 12/4/19.
//  Copyright © 2019 Fusion Corp Design. All rights reserved.
//

import UIKit

class JediViewController: UIViewController, JediTableCellDelegate  {
    
    func toggleHasBeenRead(for View: JediDetailViewController) {
        setupView()
    }
    
    let jediVM = JediViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
    }
    
    // Elements
    @IBOutlet weak var jediTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
}

private extension JediViewController {
    func setupView(){
        jediVM.loadFromPersistence()
        jediVM.getAllJedis { (error) in
            self.jediTableView.reloadData()
        }
        jediTableView.delegate = self
        jediTableView.dataSource = self
        searchBar.delegate = self
        searchBar.backgroundColor = .black
        searchBar.tintColor = .black
    }
}

extension JediViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jediVM.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .jediTableViewCellID, for: indexPath) as! JediTableViewCell
        let result = jediVM.result[indexPath.row]
        cell.result = result
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .segueID {
            let detailVC = segue.destination as! JediDetailViewController
            if let indexPath = jediTableView.indexPathForSelectedRow {
                let result = jediVM.result[indexPath.row]
                detailVC.result = result
            }
        }
    }
}

extension JediViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        jediVM.getJedis(with: searchText) { (error) in
            self.jediTableView.reloadData()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
