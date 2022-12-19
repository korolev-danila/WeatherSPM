//
//  SearchView.swift
//  WeatherService
//
//  Created by Данила on 18.11.2022.
//

import UIKit
import SnapKit

protocol SearchViewInputProtocol: AnyObject {
    func reloadTableView()
    func startAnimation()
    func stopAnimation()
}

protocol SearchViewOutputProtocol {
    func viewModel(_ index: IndexPath) -> SearchViewModel
    func citysCount() -> Int
    func save(_ index: IndexPath)
    func requestCities(_ string: String)
}

final class SearchViewController: UIViewController {
    private let presenter: SearchViewOutputProtocol
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let activityView: UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(style: .large)
        return act
    }()
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search City"
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.backgroundColor = .clear
        tf.layer.cornerRadius = 15.0
        tf.layer.borderWidth = 2.0
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = UITextField.BorderStyle.none
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = UITextField.ViewMode.always
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        return tf
    }()
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(SearchCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .clear
        tv.keyboardDismissMode = .onDrag
        return tv
    }()
    
    // MARK: - Initialize & viewDidLoad
    init(presenter: SearchViewOutputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        textField.becomeFirstResponder()
    }
    
    deinit {
        print("deinit SearchViewController")
    }
    
    // MARK: - Private method
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(textField)
        view.addSubview(cancelButton)
        view.addSubview(tableView)
        view.addSubview(activityView)
        
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        cancelButton.addTarget(self, action: #selector(cancelPress), for: .touchUpInside)
        
        activityView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(-75)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(cancelButton.snp.leading)
            make.height.equalTo(44)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.width.equalTo(66)
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(55)
            make.bottom.equalTo(view.snp_bottomMargin)
            make.leading.equalTo(view.snp_leadingMargin)
            make.trailing.equalTo(view.snp_trailingMargin)
        }
    }
    
    @objc func cancelPress() {
        self.dismiss(animated: true, completion: nil)
    }
}



// MARK: - SearchViewInputProtocol
extension SearchViewController: SearchViewInputProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func startAnimation() {
        activityView.startAnimating()
    }
    
    func stopAnimation() {
        activityView.stopAnimating()
    }
}



// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        var search = ""
        
        if string.isEmpty {
            if let text = textField.text {
                search = String(text.dropLast())
            }
        } else {
            if let text = textField.text {
                search = text + string
            }
        }
        
        presenter.requestCities(search)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        activityView.stopAnimating()
        return true
    }
}

// MARK: - TableViewController Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.save(indexPath)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.citysCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! SearchCell
        
        cell.configureCell(presenter.viewModel(indexPath))
        return cell
    }
}
