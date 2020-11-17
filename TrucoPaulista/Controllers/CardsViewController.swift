//
//  CardsViewController.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import UIKit
import SDWebImage

class CardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var deckID: String? = ""
    var rotationCard: String = ""
    var cardCount: Int = 0
    var highestNumber: String = ""
    @IBOutlet var lblPossibilities: UILabel?
    
    var higherCardFound: Bool = false
    
    var orderArray: Array<String> = ["6", "5", "4", "3", "2", "A", "K", "Q", "J", "0", "9", "8", "7"]
    
    @IBOutlet var cvCards: UICollectionView?
    @IBOutlet var constraintHeightCollectionView: NSLayoutConstraint?
    @IBOutlet var imgHigherCard: UIImageView?
    
    var cardsArray: Array<Card> = []
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UICollectionView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let card = cardsArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell
        cell?.loadUI(item: card)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //-----------------------------
    //  Flow layout
    //-----------------------------
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    //-----------------------------------------------------------------------
    //    MARK:- Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {
        self.requestCards()
    }
    
    func loadUI() {
        
    }
    
    func requestCards() {
        
        RequestManager().drawCards(deckID: self.deckID ?? "", cardCount: self.cardCount) { (success, response, message) in
            
            if success {
                self.cardsArray = response?.cards ?? []
                
                self.getHigherCard()
                self.configureCvHeight()
                self.organizeOrder()
                
                let higherCard = self.cardsArray.filter({$0.code == self.highestNumber})
                
                self.imgHigherCard?.sd_setImage(with: URL(string: higherCard.first?.image ?? ""))
                
                self.cvCards?.reloadData()
            }else{
                
            }
        }
    }
    
    func organizeOrder() {
        if self.rotationCard.contains("h") {
            
            var fullArray: Array<Card> = []
            
            let newArray = self.cardsArray.filter({$0.suit == "HEARTS"})
            let secondArray = self.cardsArray.filter({$0.suit == "DIAMONDS"})
            let thirdArray = self.cardsArray.filter({$0.suit == "SPADES"})
            let fourthArray = self.cardsArray.filter({$0.suit == "CLUBS"})
            
            fullArray.append(contentsOf: newArray)
            fullArray.append(contentsOf: secondArray)
            fullArray.append(contentsOf: thirdArray)
            fullArray.append(contentsOf: fourthArray)
            
            var organizedCards: Array<Card> = []
            
            let rotation = self.rotationCard.substring(to: 1)
            var count = self.orderArray.firstIndex(of: rotation) ?? 0

            for item in fullArray {
                for order in orderArray {
                    if order.capitalized == item.code?.substring(to: 1).capitalized {
                        organizedCards.append(item)
                    }
                }
                count += 1
            }
        
            let cardsArray = checkOrder(cards: organizedCards).removeDuplicates()
            
            getFullHouses(cards: cardsArray)
            self.cardsArray = cardsArray
            
        }else if self.rotationCard.contains("d") {
            
            var fullArray: Array<Card> = []
            
            let newArray = self.cardsArray.filter({$0.suit == "DIAMONDS"})
            let secondArray = self.cardsArray.filter({$0.suit == "CLUBS"})
            let thirdArray = self.cardsArray.filter({$0.suit == "SPADES"})
            let fourthArray = self.cardsArray.filter({$0.suit == "HEARTS"})
            
            fullArray.append(contentsOf: newArray)
            fullArray.append(contentsOf: secondArray)
            fullArray.append(contentsOf: thirdArray)
            fullArray.append(contentsOf: fourthArray)
            
            var organizedCards: Array<Card> = []
            
            let rotation = self.rotationCard.substring(to: 1)
            var count = self.orderArray.firstIndex(of: rotation)
            
            for item in fullArray {
                for order in orderArray {
                    if order.capitalized == item.code?.substring(to: 1).capitalized {
                        organizedCards.append(item)
                    }
                }
                count! += 1
            }
            
            self.cardsArray = checkOrder(cards: organizedCards).removeDuplicates()
            
        }else if self.rotationCard.contains("c") {
            
            var fullArray: Array<Card> = []
            
            let newArray = self.cardsArray.filter({$0.suit == "CLUBS"})
            let secondArray = self.cardsArray.filter({$0.suit == "SPADES"})
            let thirdArray = self.cardsArray.filter({$0.suit == "HEARTS"})
            let fourthArray = self.cardsArray.filter({$0.suit == "DIAMONDS"})
            
            fullArray.append(contentsOf: newArray)
            fullArray.append(contentsOf: secondArray)
            fullArray.append(contentsOf: thirdArray)
            fullArray.append(contentsOf: fourthArray)
            
            var organizedCards: Array<Card> = []
            
            let rotation = self.rotationCard.substring(to: 1)
            var count = self.orderArray.firstIndex(of: rotation)
            
            for item in fullArray {
                for order in orderArray {
                    if order.capitalized == item.code?.substring(to: 1).capitalized {
                        organizedCards.append(item)
                    }
                }
                count! += 1
            }
            
            self.cardsArray = checkOrder(cards: organizedCards).removeDuplicates()
            
        }else if self.rotationCard.contains("s") {
            
            var fullArray: Array<Card> = []
            
            let newArray = self.cardsArray.filter({$0.suit == "SPADES"})
            let secondArray = self.cardsArray.filter({$0.suit == "HEARTS"})
            let thirdArray = self.cardsArray.filter({$0.suit == "DIAMONDS"})
            let fourthArray = self.cardsArray.filter({$0.suit == "CLUBS"})
            
            fullArray.append(contentsOf: newArray)
            fullArray.append(contentsOf: secondArray)
            fullArray.append(contentsOf: thirdArray)
            fullArray.append(contentsOf: fourthArray)
            
            var organizedCards: Array<Card> = []
            
            let rotation = self.rotationCard.substring(to: 1)
            var count = self.orderArray.firstIndex(of: rotation)
            
            for item in fullArray {
                for order in orderArray {
                    if order.capitalized == item.code?.substring(to: 1).capitalized {
                        organizedCards.append(item)
                    }
                }
                count! += 1
            }
            
            self.cardsArray = checkOrder(cards: organizedCards).removeDuplicates()
        }
    }
    
    func getFullHouses(cards: [Card]) {
        
        var cardCodeArray: Array<String> = []
        
        var mainArray: Array<String> = []
        var secondArray: Array<String> = []
        
        for card in cards {
            cardCodeArray.append(card.code ?? "")
        }
        
        for item in splitDups(cardCodeArray) {
            if item.count == 3 {
                mainArray.append(contentsOf: item)
            }else if item.count == 2 {
                secondArray.append(contentsOf: item)
            }
        }
        
        let arrayOne = permute(list: mainArray, minStringLen: 3)
        let arrayTwo = permute(list: secondArray, minStringLen: 2)
        
        let probabilities = arrayOne.count + arrayTwo.count
        lblPossibilities?.text = "\(probabilities)"
    }
    
    func splitDups(_ items: Array<String>) -> Array<Array<String>> {
        
        var keys: Array<String> = []
        var duplicated: Array<Array<String>> = []

        for item in items {
            
            let bound = String.Index(utf16Offset: 0, in: item)
            
            let key = String(item[bound...bound])
            if !keys.contains(key) {
                keys.append(key)
                duplicated.append(items.filter({$0.contains(key)}))
            }
        }
        
        return duplicated
    }
    
    func checkOrder(cards: [Card]) -> Array<Card>{
        
        var newArray: Array<Card> = []
        
        let rotation = self.rotationCard.substring(to: 1)
        let count = self.orderArray.firstIndex(of: rotation) ?? 0
        
        let newOrderArray = orderArray[count..<orderArray.count] + orderArray.prefix(count)
        
        for order in newOrderArray {
            for card in cards {
                if card.code?.substring(to: 1) == order {
                    newArray.append(card)
                }
            }
        }
        
        var fullArray: Array<Card> = []
        
        let new = newArray.filter({$0.suit == "HEARTS"})
        let secondArray = newArray.filter({$0.suit == "DIAMONDS"})
        let thirdArray = newArray.filter({$0.suit == "SPADES"})
        let fourthArray = newArray.filter({$0.suit == "CLUBS"})
        
        fullArray.append(contentsOf: new)
        fullArray.append(contentsOf: secondArray)
        fullArray.append(contentsOf: thirdArray)
        fullArray.append(contentsOf: fourthArray)
        
        return fullArray
    }
    
    func getHigherCard() {
        let rotation = self.rotationCard.substring(to: 1)
        var count = self.orderArray.firstIndex(of: rotation)
        
        for item in self.cardsArray {
            
            let cardcode = item.code?.substring(to: 1)
            
            if cardcode == rotation {
                self.highestNumber = item.code ?? ""
            }else{
                
                for card in self.cardsArray {
                    if self.orderArray[count ?? 0].capitalized.contains(card.code?.substring(to: 1).capitalized ?? "") && self.rotationCard.substring(from: 1).capitalized == card.code?.substring(from: 1).capitalized {
                        if self.higherCardFound == false {
                            self.highestNumber = card.code ?? ""
                            self.higherCardFound = true
                        }
                    }else{
                        //
                    }
                }
                count! += 1
            }
        }
        
        if self.higherCardFound == false {
            for card in self.cardsArray {
                if self.orderArray[count ?? 0].capitalized.contains(card.code?.substring(to: 1).capitalized ?? "") {
                    if self.higherCardFound == false {
                        self.highestNumber = card.code ?? ""
                        self.higherCardFound = true
                    }
                }else{
                    count! += 1
                }
            }
        }

    }
    
    func permute(list: [String], minStringLen: Int) -> Set<String> {
        func permute(fromList: [String], toList: [String], minStringLen: Int, set: inout Set<String>) {
            if toList.count >= minStringLen {
                set.insert(toList.joined(separator: ","))
            }
            if !fromList.isEmpty {
                for (index, item) in fromList.enumerated() {
                    var newFrom = fromList
                    newFrom.remove(at: index)
                    permute(fromList: newFrom, toList: toList + [item], minStringLen: minStringLen, set: &set)
                }
            }
        }

        var set = Set<String>()
        permute(fromList: list, toList:[], minStringLen: minStringLen, set: &set)
        return set
    }
    
    func configureCvHeight() {
        if self.cardsArray.count <= 4 {
            self.constraintHeightCollectionView?.constant = 120
        }else{
            self.constraintHeightCollectionView?.constant = 240
        }
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}
