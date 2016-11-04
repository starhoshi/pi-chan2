//
//  ESAApiClient.swift
//  pi-chan2
//
//  Created by Kensuke Hoshikawa on 2016/11/04.
//  Copyright © 2016年 star__hoshi. All rights reserved.
//

import Foundation
import APIKit
import Toaster

final class ESAApiClient {
    private init() {

    }

    static func errorHandler(error: SessionTaskError) {
        log?.error("\(error)")

        switch error {
        case .connectionError(_):
            Toast.showLong(text: "ネットワークエラーです。(\\( ⁰⊖⁰)/)\n\nネットワーク状況を確認ください。")
        case .requestError(_):
            Toast.showLong(text: "エラーが発生しました。(\\( ⁰⊖⁰)/)\n\nしばらく経ってから再度お試しください。")
        case .responseError(let error as Unauthorized):
            error.showLoginWindow()
        case .responseError(let error as NotFound):
            error.showToast()
        default:
            Toast.showLong(text: "エラーが発生しました。(\\( ⁰⊖⁰)/)\n\nしばらく経ってから再度お試しください。")
        }
    }
}

struct Unauthorized: Error {
    func showLoginWindow() {
        // UIApplication.topViewController().
        Toast.showLong(text: "esa.io での認証が必要です (\\( ⁰⊖⁰)/)\nログインをお願いします。")
    }
}

struct NotFound: Error {
    func showToast() {
        Toast.showLong(text: "該当の URL が見つかりませんでした。(\\( ⁰⊖⁰)/)")
    }
}
