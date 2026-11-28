function fuzz(query, list, keys, usage) {
  const q = query.toLowerCase()
  const uses = item => (usage ? usage(item) : 0)
  if (!q.length)
    return [...list].sort((a, b) => uses(b) - uses(a))

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
    .sort((a, b) => a.score - b.score || uses(b.item) - uses(a.item))
    .map(x => x.item)
}
