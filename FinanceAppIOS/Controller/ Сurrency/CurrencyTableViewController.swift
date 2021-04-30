//
//  CurrencyTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 15.01.2021.
//

import UIKit

let infCurrency: [[String]] = [["EUR","Евро"], ["ALL","Албанский лек"], ["BYN","Белорусский рубль"], ["BGN","Болгарский лев"], ["BAM","Конвертируемая марка"], ["GBP","Фунт стерлингов"], ["HUF","Венгерский форинт"], ["DKK","Датская крона"], ["ISK","Исландская крона"], ["MDL","Молдавский лей"], ["NOK","Норвежская крона"], ["PLN","Польский злотый"], ["RON","Румынский лей"], ["RUB","Российский рубль"], ["MKD","Македонский динар"], ["RSD","Сербский динар"], ["UAH","Гривна"], ["CZK","Чешская крона"], ["HRK","Хорватская куна"], ["SEK","Шведская крона"], ["CHF","Швейцарский франк"], ["AZN","Азербайджанский манат"], ["AMD","Армянский драм"], ["VND","Вьетнамский донг"], ["HKD","Гонконгский доллар"], ["GEL","Лари"], ["ILS","Шекель"], ["INR","Индийская рупия"], ["IDR","Индонезийская рупия"], ["KZT","Тенге"], ["KGS","Киргизский сом"], ["KZT","Китайский юань"], ["KWD","Кувейтский динар"], ["AED","Дирхам"], ["SGD","Сингапурский доллар"], ["TJS","Таджикский сомони"], ["THB","Бат"], ["TMT","Туркменский манат"], ["TRY","Турецкая лира"], ["UZS","Узбекский сум"], ["KRW","Вона"], ["JPY","Японская йена"], ["ARS","Аргентинское песо"], ["BRL","Бразильский реал"], ["CAD","Канадский доллар"], ["COP","Колумбийское песо"], ["MXN","Мексиканский песо"], ["PEN","Перуанский соль"], ["USD","Доллар США"], ["UYU","Уругвайское песо"], ["CLP","Чилийское песо"], ["EGP","Египетский фунт"], ["ZAR","Рэнд"], ["AUD","Австралийский доллар"], ["NZD","Новозеландский доллар"], ["BTC","Биткоин"], ["    ETH","Эфириум"], ["USDT","Tether"], ["DOT","Polkadot"], ["XRP","Рипл"], ["ADA","Cardano"], ["LTC","Лайткоин"], ["BCH","Bitcoin Cash"], ["    LINK","Chainlink"], ["XLM","Stellar"]]

class CurrencyTableViewController: UITableViewController {
    
    var delegateCurrencyPurse: CreatePurseTableViewController?
    
    var delegateCurrencyTransaction: CreateTransactionTableViewController?
    
    var delegateCurrencyDebt: CreateDebtTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return infCurrency.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyTableView", for: indexPath)
        cell.textLabel?.text = infCurrency[indexPath.row][1]
        cell.detailTextLabel?.text = infCurrency[indexPath.row][0]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateCurrencyPurse?.updateCurrency(text: infCurrency[indexPath.row][1], initial: infCurrency[indexPath.row][0])
        delegateCurrencyTransaction?.updateCurrency(text: infCurrency[indexPath.row][1], initial: infCurrency[indexPath.row][0])
        delegateCurrencyDebt?.updateCurrency(text: infCurrency[indexPath.row][1], initial: infCurrency[indexPath.row][0])
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
        
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let verticalPadding: CGFloat = 4
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    

    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
