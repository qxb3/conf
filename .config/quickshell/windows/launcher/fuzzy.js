function fuzz(query, list, keys) {
  const q = query.toLowerCase()
  if (!q.length)
    return list

  const keyList = Array.isArray(keys) ? keys : [keys]

  return list
    .map(item => {
      let bestScore = Infinity
      let matched = false

      for (const key of keyList) {
        const str = key ? item[key] : item
        if (typeof str !== "string")
          continue

        const s = str.toLowerCase()
        let score = 0
        let lastIndex = -1

        for (const char of q) {
          const idx = s.indexOf(char, lastIndex + 1)
          if (idx === -1) {
            score = Infinity
            break
          }

          score += idx - lastIndex
          lastIndex = idx
        }

        if (score < bestScore) {
          bestScore = score
          matched = score < Infinity
        }
      }

      return matched ? { item, score: bestScore } : null
    })
    .filter(Boolean)
    .sort((a, b) => a.score - b.score)
    .map(x => x.item)
}
