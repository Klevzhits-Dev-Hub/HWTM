import Foundation

final class UserDefaultsService {
    private let ud = UserDefaults.standard

    // Ключи
    private enum Keys {
        static let bestScore = "bestScore"
        static let gameState = "gameState"
    }

    // MARK: - Save
    func saveBestScore(_ score: Int) {
        ud.set(score, forKey: Keys.bestScore)
    }

    func saveGame(_ game: Game) {
        ud.set(game, forKey: Keys.gameState)
    }

    // MARK: - Get
    func getBestScore() -> Int {
        ud.integer(forKey: Keys.bestScore)
    }

    func getGame() -> Game? {
        ud.object(forKey: Keys.gameState) as? Game
    }

    // MARK: - Delete
    func resetAll() {
        ud.removeObject(forKey: Keys.bestScore)
        ud.removeObject(forKey: Keys.gameState)
    }
}
