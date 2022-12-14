//
//  File.swift
//  
//
//  Created by Данила on 04.12.2022.
//

import Foundation


struct News: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status, totalResults, articles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try? container.decode(String.self, forKey: .status)
        self.totalResults = try? container.decode(Int.self, forKey: .totalResults)
        self.articles = try? container.decode([Article].self, forKey: .articles)
    }
}



// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try? container.decode(Source.self, forKey: .source)
        self.author = try? container.decode(String.self, forKey: .author)
        self.title = try? container.decode(String.self, forKey: .title)
        self.articleDescription = try? container.decode(String.self, forKey: .articleDescription)
        self.url = try? container.decode(String.self, forKey: .url)
        self.urlToImage = try? container.decode(String.self, forKey: .urlToImage)
        self.publishedAt = try? container.decode(String.self, forKey: .publishedAt)
        self.content = try? container.decode(String.self, forKey: .content)
    }
}



// MARK: - Source
struct Source: Codable {
    let id, name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.name = try? container.decode(String.self, forKey: .name)
    }
}
