//
//  ViewController.swift
//  WeatherService
//
//  Created by Данила on 17.11.2022.
//

import UIKit
import SnapKit

protocol MainViewInputProtocol: AnyObject {
    func reloadTableView()
}

protocol MainViewOutputProtocol {
    func viewDidLoad()
    func didTapButton()
    func showDetails(index: IndexPath)
    func deleteCity(for index: IndexPath) -> Int
    func deleteAll()
    func countrysCount() -> Int
    func sectionArrayCount(_ section: Int) -> Int
    func createHeaderViewModel(_ section: Int) -> HeaderCellViewModel
    func createCellViewModel(for index: IndexPath) -> MainCellViewModel
    func updateFlag(forSection section: Int)
}

final class MainViewController: UIViewController {
    private let presenter: MainViewOutputProtocol
    
    private var deleteIsHidden = true {
        didSet {
            searchButton.isHidden = !deleteIsHidden
            searchButton.isEnabled = deleteIsHidden
        }
    }
    private let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 35,
                                                                           weight: .semibold))
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .white
        button.layer.cornerRadius = 25
        button.clipsToBounds = false
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    private let tableView: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(MainCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .clear
        return tv
    }()
    private var hasAnimatedAllCells = false
    
    // MARK: - Initialize Method
    init(presenter: MainViewOutputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        settingNC()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Private method
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(searchButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchButton.addTarget(self, action: #selector(addTapButton), for: .touchUpInside)
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80.0)
            make.trailing.equalToSuperview().inset(55.0)
            make.height.equalTo(50.0)
            make.width.equalTo(50.0)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
        
    private func settingNC() {
        navigationController?.navigationBar.topItem?.title = "Citys"
        navigationController?.navigationBar.prefersLargeTitles = false
        setEditButton()
    }
    
    private func setEditButton() {
        let editBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 30))
        editBarButton.setTitle("Edit", for: .normal)
        editBarButton.setTitleColor(.systemBlue, for: .normal)
        editBarButton.addTarget(self, action: #selector(editButtonTap), for: .touchUpInside)
        
        let leftButton = UIBarButtonItem(customView: editBarButton)
        navigationItem.setLeftBarButton(leftButton, animated: true)
        navigationItem.setRightBarButton(nil, animated: true)
    }
    
    // MARK: - Actions
    @objc private func editButtonTap() {
        deleteIsHidden = false
        tableView.reloadData()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        doneButton.tintColor = .systemBlue
        navigationItem.setLeftBarButton(doneButton, animated: true)
        
        let deleteButton = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(deleteButtonTap))
        deleteButton.tintColor = .systemRed
        navigationItem.setRightBarButton(deleteButton, animated: true)
    }
    
    @objc private func deleteButtonTap() {
        let alert = UIAlertController(title: "Attention", message: "Do you want to delete all cities?",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            guard let _self = self else { return }
            _self.setEditButton()
            _self.deleteIsHidden = true
            _self.presenter.deleteAll()
            _self.reloadTableView()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { [weak self] _ in
            guard let _self = self else { return }
            _self.setEditButton()
            _self.deleteIsHidden = true
            _self.tableView.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func doneButtonTap() {
        setEditButton()
        deleteIsHidden = true
        tableView.reloadData()
    }
    
    @objc private func addTapButton() {
        presenter.didTapButton()
    }
}

// MARK: - MainViewInputProtocol
extension MainViewController: MainViewInputProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.countrysCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if deleteIsHidden {
            navigationController?.navigationBar.prefersLargeTitles = false
            presenter.showDetails(index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sectionArrayCount(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! MainCell
        
        cell.delegate = self
        cell.configureCell(presenter.createCellViewModel(for: indexPath), deleteIsHid: deleteIsHidden)
        return cell
    }
    
    // MARK: - Headers Method&UI
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect.init(x: 0, y: 0,
                                                       width: tableView.frame.width,
                                                       height: 60))
        let viewModel = presenter.createHeaderViewModel(section)
        
        if UIImage(data: viewModel.imgData) == nil {
            presenter.updateFlag(forSection: section)
        }
        
        headerView.settingCell(viewModel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !hasAnimatedAllCells else { return }

        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: { cell.alpha = 1 }
        )
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}

// MARK: - MainViewCellDelegate
extension MainViewController: MainViewCellDelegate {
    func delete(cell: MainCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let countOfCitys = presenter.deleteCity(for: indexPath)
        
        if countOfCitys == 1 {
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            tableView.deleteSections(indexSet, with: .right)
        } else {
            tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
}
