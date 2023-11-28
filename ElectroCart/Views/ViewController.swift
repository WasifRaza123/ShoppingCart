//
//  ViewController.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 01/11/23.
//

import UIKit


class ViewController: UIViewController {
    private var shadowLayer: CAShapeLayer!
    
    let searchBar = UISearchBar()
    var filteredItems = [Product]()
    private let viewModel = ProductViewModel()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        applyConstraints()
        viewModel.fetchProducts()
        viewModel.eventHandler = {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else{
                    return
                }
                strongSelf.filteredItems = strongSelf.viewModel.products
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    func applyConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell ?? TableViewCell(style: .default, reuseIdentifier: "cell")
        cell.titleLabel.text = self.filteredItems[indexPath.row].title
        cell.ratingLabel.text = "Rating\(self.filteredItems[indexPath.row].rating)"
        cell.priceLabel.text = "Rs.\(self.filteredItems[indexPath.row].price)"
        cell.configureImage(fromUrl: self.filteredItems[indexPath.row].thumbnail)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductViewController(product: self.filteredItems[indexPath.row])
        present(vc, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.replacingOccurrences(of: " ", with: "").isEmpty else {
            self.filteredItems = viewModel.products
            self.tableView.reloadData()
            return
        }
        
        filteredItems = viewModel.products.filter {
                    $0.title.lowercased().contains(searchText.lowercased()) || $0.category.lowercased().contains(searchText.lowercased())
                }
        self.tableView.reloadData()
        
    }
}
