//
//  Migration.swift
//  MusicImport
//
//  Created by Данил Войдилов on 25.01.2022.
//  Copyright © 2022 Данил Войдилов. All rights reserved.
//

import Foundation
import App
import Vapor
import Fluent
import SimpleCoders
import VDCodable

let logger = Logger(label: "app")

public struct FIRTrack<T: Codable>: Codable {
	public var track: T?
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		track = try? container.decodeIfPresent(T.self, forKey: .track)
	}
}

public struct FIRTracks<T: Codable & TrackProtocol>: Decodable {
	public var tracks: [MigrateTrack]
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: PlainCodingKey.self)
		tracks = try container.allKeys.compactMap({ ServiceType(rawValue: $0.stringValue) }).flatMap {
			try container.decode([String: Document<T>].self, forKey: PlainCodingKey($0.rawValue)).compactMap { k in
				k.value.first.track.map { MigrateTrack(ids: k.value.second.value, track: $0.trackInfo) }
			}
		}
	}
}

public typealias Document<T: Codable> = MIUnion<FIRTrack<T>, Links>

public struct Links: Codable, ExpressibleByDictionaryLiteral {
	public var value: [ServiceType: String] = [:]
	
	public init() {}
	
	public init(dictionaryLiteral elements: (ServiceType, String)...) {
		value = Dictionary(elements, uniquingKeysWith: {_, p in p })
	}
	
	public subscript(_ key: ServiceType) -> String? {
		get { value[key] }
		set { value[key] = newValue }
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: ServiceType.self)
		var dict: [ServiceType: String] = [:]
		try container.allKeys.forEach {
			dict[$0] = try container.decodeIfPresent(String.self, forKey: $0)
		}
		value = dict
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: ServiceType.self)
		try value.forEach {
			try container.encode($0.value, forKey: $0.key)
		}
	}
}

public struct MIUnion<A, B> {
	public var first: A
	public var second: B
	
	public init(_ a: A, _ b: B) {
		first = a
		second = b
	}
}

extension MIUnion: Decodable where A: Decodable, B: Decodable {
	
	public init(from decoder: Decoder) throws {
		first = try A.init(from: decoder)
		second = try B.init(from: decoder)
	}
}

extension MIUnion: Encodable where A: Encodable, B: Encodable {
	
	public func encode(to encoder: Encoder) throws {
		try first.encode(to: encoder)
		try second.encode(to: encoder)
	}
}


public struct MigrateTrack: Decodable {
	public var ids: [ServiceType: String] = [:]
	public var track: Track
}

public enum DecodableCase<F: Codable, S: Codable>: Codable {
	case f(F), s(S)
	
	public init(from decoder: Decoder) throws {
		do {
			let f = try F.init(from: decoder)
			self = .f(f)
		} catch {
			let s = try S.init(from: decoder)
			self = .s(s)
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		switch self {
		case .f(let f):
			try f.encode(to: encoder)
		case .s(let s):
			try s.encode(to: encoder)
		}
	}
}

extension DecodableCase: TrackProtocol where F: TrackProtocol, S: TrackProtocol {
	public var trackInfo: Track {
		switch self {
		case .s(let s): return s.trackInfo
		case .f(let f): return f.trackInfo
		}
	}
}
