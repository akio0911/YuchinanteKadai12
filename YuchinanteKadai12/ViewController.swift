//
//  ViewController.swift
//  
//  
//  Created by Yuchinante on 2024/04/04
//  
//

import UIKit

class ViewController: UIViewController {
    // 価格（税抜き）入力用のテキストフィールド
    @IBOutlet weak var amountExcludingTaxTextField: UITextField!

    // 消費税率入力用のテキストフィールド
    @IBOutlet weak var salesTaxRateTextField: UITextField!
    
    // 価格（税込み）表示用のラベル
    @IBOutlet weak var amountIncludingTaxLabel: UILabel!

    // UserDefaultsに保存するためのキー
    let KeySalesTaxRate = "salesTaxRate"

    // 画面がロードされた時の処理
    override func viewDidLoad() {
        super.viewDidLoad()

        // UserDefaultsから消費税率を取得してテキストフィールドに表示
        if UserDefaults.standard.object(forKey: KeySalesTaxRate) != nil {
            salesTaxRateTextField.text! = UserDefaults.standard.object(forKey: KeySalesTaxRate) as! String
        }
    }

    // 消費税率が変更された時のアクション
    @IBAction func salesTaxRateAction(sender: AnyObject) {
        // UserDefaultsに消費税率を保存し、同期する
        UserDefaults.standard.set(self.salesTaxRateTextField.text, forKey:KeySalesTaxRate)
        UserDefaults.standard.synchronize()
    }

    // 計算ボタンがタップされた時のアクション
    @IBAction func calculationButton(sender: AnyObject) {
        // 価格（税抜き）を取得
        let amountExcludingTax = (amountExcludingTaxTextField.text! as NSString).integerValue

        // 消費税率を取得
        let salesTaxRate = (salesTaxRateTextField.text! as NSString).floatValue

        // 価格（税込み）を計算してラベルに表示
        let amountIncludingTax = Int(Float(amountExcludingTax) * (1.0 + salesTaxRate / 100.0))
        self.amountIncludingTaxLabel.text = "\(amountIncludingTax)"
    }
}
