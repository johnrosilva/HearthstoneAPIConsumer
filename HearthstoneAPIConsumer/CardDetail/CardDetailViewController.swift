//
//  CardDetailViewController.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 30/05/23.
//

import UIKit

class CardDetailViewController: HearthStoneAPIBaseViewController {
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flavorLabel = CardLabel()
    private let descriptionLabel = CardLabel()
    private let setLabel = CardLabel()
    private let typeLabel = CardLabel()
    private let factionLabel = CardLabel()
    private let rarityLabel = CardLabel()
    private let attackLabel = CardLabel()
    private let costLabel = CardLabel()
    private let healthLabel = CardLabel()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    let viewModel: CardDetailViewModel
    
    init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Card Details"
        view.backgroundColor = .white
        setupViews()
        fetchCardDetails()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupViews() {
        addViews()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            cardImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CardDimensions.imageTopMargin),
            cardImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            cardImageView.widthAnchor.constraint(equalToConstant: CardDimensions.imageWidth),
            cardImageView.heightAnchor.constraint(equalToConstant: CardDimensions.imageHeight),
            
            nameLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            
            flavorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            flavorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            flavorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -CardDimensions.labelHorizontalMargin),
            
            descriptionLabel.topAnchor.constraint(equalTo: flavorLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -CardDimensions.labelHorizontalMargin),
            
            setLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            setLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            
            typeLabel.topAnchor.constraint(equalTo: setLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            
            factionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            factionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            
            rarityLabel.topAnchor.constraint(equalTo: factionLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            rarityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            
            attackLabel.topAnchor.constraint(equalTo: rarityLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            attackLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            
            costLabel.topAnchor.constraint(equalTo: attackLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            costLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            
            healthLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: CardDimensions.labelVerticalSpacing),
            healthLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CardDimensions.labelHorizontalMargin),
            healthLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -CardDimensions.labelVerticalSpacing),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(cardImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(flavorLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(setLabel)
        containerView.addSubview(typeLabel)
        containerView.addSubview(factionLabel)
        containerView.addSubview(rarityLabel)
        containerView.addSubview(attackLabel)
        containerView.addSubview(costLabel)
        containerView.addSubview(healthLabel)
        view.addSubview(activityIndicatorView)
    }
    
    private func fetchCardDetails() {
        self.showLoadingIndicator()
        viewModel.fetchCardDetails()
    }
    
    private func displayCardDetails() {
        guard let cardDetails = viewModel.cardDetails else {
            return
        }
        
        DispatchQueue.main.async {
            if let cardImage = cardDetails.cardImageURL {
                ImageHelper.default.getImage(cardImage, forSize: CardDimensions.imageSize) { [weak self] image in
                    self?.cardImageView.image = image
                }
            } else {
                self.cardImageView.image = UIImage(named: "default_card")
            }
            
            self.nameLabel.text = cardDetails.name
            
            self.flavorLabel.attributedText = self.attributedString(from: cardDetails.flavorText)
            self.descriptionLabel.attributedText = self.attributedString(from: cardDetails.shortDescription)
            self.setLabel.text = "Set: \(cardDetails.cardSet ?? self.viewModel.emptyInfo)"
            self.typeLabel.text = "Type: \(cardDetails.type ?? self.viewModel.emptyInfo)"
            self.factionLabel.text = "Faction: \(cardDetails.faction ?? self.viewModel.emptyInfo)"
            self.rarityLabel.text = "Rarity: \(cardDetails.rarity ?? self.viewModel.emptyInfo)"
            self.attackLabel.text = "Attack: \(cardDetails.attack ?? 0)"
            self.costLabel.text = "Cost: \(cardDetails.cost ?? 0)"
            self.healthLabel.text = "Health: \(cardDetails.health ?? 0)"
        }
    }
    
    private func attributedString(from htmlText: String?) -> NSAttributedString? {
        guard let text = htmlText, let data = text.data(using: .utf8) else {
            return nil
        }
        
        do {
            let attributedString = try NSAttributedString(data: data,
                                                           options: [.documentType: NSAttributedString.DocumentType.html],
                                                           documentAttributes: nil)
            return attributedString
        } catch {
            print("Failed to create attributed string from HTML: \(error)")
            return nil
        }
    }
}

extension CardDetailViewController: CardDetailViewModelDelegate {
    func cardDetailsFetched() {
        self.hideLoadingIndicator()
        self.displayCardDetails()
    }
    
    func cardDetailsFetchFailed(withError error: Error) {
        self.hideLoadingIndicator()
        self.showAlert(message: error.localizedDescription)
    }
}
