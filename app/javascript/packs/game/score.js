class Score {
  constructor() {
    this.currentScore = 0
  }

  updateScore(frames) {
    return this.currentScore += Math.round(frames / 10)
  }

  jumpScore() {
    this.currentScore += 10
  }
}

export default Score