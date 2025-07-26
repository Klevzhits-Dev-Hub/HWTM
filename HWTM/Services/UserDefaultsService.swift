import Foundation

final class UserDefaultsService {
    private let ud = UserDefaults.standard

    // Ключи
    private enum Keys {
        static let hasPlayed = "hasPlayed"
        static let bestScore = "bestScore"
        static let gameState = "gameState"
    }

    // MARK: - Save
    func saveHasPlayed() {
        ud.set(true, forKey: Keys.hasPlayed)
    }

    func saveBestScore(_ score: Int) {
        ud.set(score, forKey: Keys.bestScore)
    }

    func saveGame(_ game: Game) {
        ud.set(game, forKey: Keys.gameState)
    }

    // MARK: - Get
    func getHasPlayed() -> Bool {
        ud.bool(forKey: Keys.hasPlayed)
    }

    func getBestScore() -> Int {
        ud.integer(forKey: Keys.bestScore)
    }

    func getGame() -> Game? {
        ud.object(forKey: Keys.gameState) as? Game
    }

    // MARK: - Delete
    func resetAll() {
        ud.removeObject(forKey: Keys.hasPlayed)
        ud.removeObject(forKey: Keys.bestScore)
        ud.removeObject(forKey: Keys.gameState)
    }
}
