//
//  SideMenuCell.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 12/15/22.
//

import UIKit

final class CustomTableCellView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let title = UILabel()
    
    func setUI(with string: String) {
        title.text = string
    }
    
    func commonInit() {
        addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
    }
    
}

final class CustomTableDetailView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let title = UILabel()
    private let imageView = UIImageView()

    func setUI(with string: String, image: UIImage) {
        title.text = "Detail View for Cell \(string)"
        imageView.image = image
    }
    
    private lazy var subListTableView: UITableView = {
        let frame = CGRect(x: 0, y: 0, width: 120, height: 80)
        let view = UITableView(frame: frame, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "test")
        
        return view
    }()
    
    func commonInit() {
        
        addSubview(title)
        addSubview(imageView)

        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        title.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -10).isActive = true

        title.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(subListTableView)
        subListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        subListTableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        subListTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        subListTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subListTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
}


extension CustomTableDetailView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        
//        var conf = cell.defaultContentConfiguration()
//        conf.text = "Test"
//        
//        cell.contentConfiguration = conf
        
        return cell
        
    }
    
}
