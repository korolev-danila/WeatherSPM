//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import UIKit
import SnapKit

protocol DetailsViewInputProtocol: AnyObject {
    
    func configureCityView()
    func configureWeatherView(indexCell: IndexPath)
    func reloadCollection()
    func reloadTableView()
    func stopShimmer()
}

protocol DetailsViewOutputProtocol {
    
    func viewDidLoad()
    func createCityViewModel() -> CityViewModel
    func createFactViewModel() -> FactViewModel
    func changeSelectCellIndex(_ index: IndexPath?) -> IndexPath
    func forecastCount() -> Int
    func forecastViewModel(heightOfCell: Double,
                           index: IndexPath) -> ForecastViewModel
    func newsCount() -> Int
    func createNewsViewModel(index: IndexPath) -> NewsViewModel
    func printItem(_ index: IndexPath)
}


final class DetailsViewController: UIViewController {
    
    private let presenter: DetailsViewOutputProtocol
        
    private let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .gray
        
        return v
    }()
    
    private let scrollUpButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 68, height: 44))
        button.setTitle("Scroll Up", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .blue
        button.clipsToBounds = false
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private let imageView: UIImageView = {
        let iView = UIImageView()
        iView.backgroundColor = .clear
        iView.contentMode = .scaleToFill
        iView.translatesAutoresizingMaskIntoConstraints = false
        
        return iView
    }()
    
    private var cityView: CitySubView = {
        let view = CitySubView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let newsTableView: DynamicTableView = {
        let tv = DynamicTableView()
        tv.backgroundColor = .gray
        tv.isHidden = false
        tv.layer.cornerRadius = 15
        tv.layer.borderWidth = 2.0
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.register(NewsCell.self, forCellReuseIdentifier: "tableCell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        
        return tv
    }()
    
    private var hasAnimatedAllCells = false
    
    private let shimmerView = ShimmerView()
    
    private let imageViewHConst: CGFloat = UIScreen.main.bounds.height / 4
    private let imageToCityConst: CGFloat = -12
    private let cityViewHConst: CGFloat = 172
    private let collectionViewHConst: CGFloat = 108
    private let collToTableConst: CGFloat = 2
    
    
    // MARK: - initialize & viewDidLoad
    init(presenter: DetailsViewOutputProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShimmerView()
        setupBarButton()
        
       
        presenter.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        shimmerView.startShimmerEffect()
    }
    
    override func viewDidLayoutSubviews() {
        
        setupScrollView()
        setupViews()
        setupScrollUpButton()
        setupContentSizeOfScroll()
    }
    
    
    deinit {
        print("deinit DetailsViewController")
    }


    
    // MARK: - SetupViews
    private func setupShimmerView() {
        view.addSubview(shimmerView)
        scrollView.isHidden = true
        
                
        shimmerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupBarButton() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = .white
    }
    
    private func setupScrollView(){
        
        view.addSubview(scrollView)
        scrollView.delegate = self
        
        
        let safeG = view.safeAreaLayoutGuide
        
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeG.snp.top)
            make.bottom.equalTo(safeG.snp.bottom)
            make.leading.equalTo(safeG.snp.leading)
            make.trailing.equalTo(safeG.snp.trailing)
        }
    }
    
    private func setupScrollUpButton() {
        scrollUpButton.addTarget(self, action: #selector(scrollButtonTapped), for: .touchUpInside)
        
        view.addSubview(scrollUpButton)
        
        scrollUpButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(100)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(88)
        }
    }
    
    private func setupViews() {
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.estimatedRowHeight = 80
        
        let contentG = scrollView.contentLayoutGuide
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(cityView)
        scrollView.addSubview(collectionView)
        scrollView.addSubview(newsTableView)
                
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentG.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(imageViewHConst)
        }
        
        cityView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(imageToCityConst)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(cityViewHConst)
        }
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cityView.snp.bottom)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(collectionViewHConst)
        }
        
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(collToTableConst)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
        }
    }
    
    private func setupContentSizeOfScroll() {
        
        let scrollViewH = imageViewHConst + imageToCityConst + cityViewHConst + collectionViewHConst + collToTableConst
        
        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: scrollViewH + newsTableView.frame.size.height)
    }
    
    // MARK: - Action scrollButtonTapped
    @objc private func scrollButtonTapped() {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
}



// MARK: - DetailsViewInputProtocol
extension DetailsViewController: DetailsViewInputProtocol {
    
    public func configureCityView() {
        let model = presenter.createCityViewModel()
        
        if let data = model.countryFlag {
            let img = UIImage(data: data)
            imageView.image = img
        }
        
        cityView.configureCityView(model)
    }
    
    public func configureWeatherView(indexCell: IndexPath) {
        let oldIndex = presenter.changeSelectCellIndex(indexCell)
        let model = presenter.createFactViewModel()
        
        collectionView.cellForItem(at: oldIndex)?.layer.borderColor = UIColor.gray.cgColor
        collectionView.cellForItem(at: oldIndex)?.layer.shadowColor = UIColor.clear.cgColor
        
        collectionView.cellForItem(at: indexCell)?.layer.borderColor = UIColor.darkGray.cgColor
        collectionView.cellForItem(at: indexCell)?.layer.shadowColor = UIColor.black.cgColor
        
        cityView.configureWeatherView(model)
    }
    
    public func reloadCollection() {
        collectionView.reloadData()
    }
    
    public func reloadTableView() {
        
        newsTableView.reloadData()
        newsTableView.invalidateIntrinsicContentSize()
        setupContentSizeOfScroll()
                
    }
    
    public func stopShimmer() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.scrollView.isHidden = false
            self.shimmerView.isHidden = true
            self.shimmerView.stopShimmerEffect()
        }
    }
}



// MARK: - UIScrollViewDelegate
extension DetailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView == self.scrollView else {
            return
        }
        
        if scrollView.bounds.intersects(collectionView.frame) == true  {
            scrollUpButton.isHidden = true
        } else if scrollView.contentOffset.y > 0 {
            if scrollUpButton.isHidden {
                scrollUpButton.isHidden = false
            }
        }
    }
}



// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter.forecastCount()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        configureWeatherView(indexCell: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        
        cell.layer.cornerRadius = 15.0
        cell.layer.borderWidth = 2.0
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        
        let selectCellIndex = presenter.changeSelectCellIndex(nil)
        if indexPath == selectCellIndex {
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.shadowColor = UIColor.black.cgColor
        } else {
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.layer.shadowColor = UIColor.clear.cgColor
        }
        
        cell.configureCell(presenter.forecastViewModel(heightOfCell: 100, index: indexPath))
        
        return cell
    }
}



// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  80
    }
    
//    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        presenter.printItem(indexPath)
//    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath) as! NewsCell
        
        cell.configureCell(presenter.createNewsViewModel(index: indexPath))
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard !hasAnimatedAllCells else {
            return
        }
        
        
        let duration = 0.5
        let delayFactor = 0.05
        cell.transform = CGAffineTransform(translationX: 0, y: 30)
        cell.alpha = 0
        
        UIView.animate(
            withDuration: duration,
            delay: delayFactor * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            })
        
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}



// MARK: - UIGestureRecognizerDelegate
extension DetailsViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

