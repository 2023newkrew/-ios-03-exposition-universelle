//
//  ExpositionService.swift
//  Expo1900
//
//  Created by kakao on 2023/01/12.
//

import UIKit

final class ExpositionService {
    private enum Text {
        static let mainAssetName = "exposition_universelle_1900"
        static let itemsAssetName = "items"
    }

    func fetchExpositionIntroductionData() -> Result<ExpositionIntroduction, DecodingError> {
        guard let data = NSDataAsset(name: Text.mainAssetName)?.data else {
            return .failure(.dataAssetConvertingFailure)
        }
        guard let product = try? JSONDecoder().decode(ExpositionIntroduction.self, from: data) else {
            return .failure(.decodingFailure)
        }
        return .success(product)
    }
    
    func fetchExpositionItemsData() -> Result<[ExpositionItem], DecodingError> {
        guard let data = NSDataAsset(name: Text.itemsAssetName)?.data else {
            return .failure(.dataAssetConvertingFailure)
        }
        guard let product = try? JSONDecoder().decode([ExpositionItem].self, from: data) else {
            return .failure(.decodingFailure)
        }
        return .success(product)
    }
}
