function tick(state, stuff) {
  playerStuff(state, stuff)
  // enemyUpdate(state, stuff)
}

function playerStuff(state, { worldWidth, worldHeight, delta }) {
  // Movement stuff.
  if (state.player.action == "attack") {
    state.player.attackTimer -= delta

    // Done attacking.
    if (state.player.attackTimer <= 0) {
      state.player.action = "idle"
      state.player.isAttacking = false
    }

    return
  }
  if (state.player.action == "shield") {
    state.player.shieldTimer -= delta

    if (state.player.shieldTimer <= 0) {
      state.player.action = "idle"
      state.player.isShielding = false
    }

    return
  }
  if (state.player.action == "idle") state.player.velX = 0
  if (state.player.action == "run" && state.player.dir == "left") state.player.velX = -300
  if (state.player.action == "run" && state.player.dir == "right") state.player.velX = 300

  // Apply velocities.
  state.player.x += state.player.velX * delta
  state.player.y += state.player.velY * delta

  // Gravity babyyy!
  state.player.velY -= 30

  // Left & Right wall invisible wall.
  if (state.player.x <= 0) state.player.x = 0
  if (state.player.x >= worldWidth.width - state.player.size) state.player.x = worldWidth - state.player.size

  // Ground collision.
  if (state.player.y <= 0) {
    state.player.y = 0
    state.player.velY = 0
    state.player.onGround = true

    if (state.player.velX > 0 || state.player.velX < 0) state.player.action = "run"
    else state.player.action = "idle"
  } else {
    state.player.onGround = false

    if (state.player.velY > 0) state.player.action = "jump"
    else state.player.action = "fall"
  }
}

function playerAttack(state) {
  if (!state.player.isAttacking || !state.player.isShielding) {
    state.player.action = "attack"
    state.player.attackTimer = 41
    state.player.isAttacking = true
  }
}

function playerShield(state) {
  if (!state.player.isAttacking || !state.player.isShielding) {
    state.player.action = "shield"
    state.player.shieldTimer = 30
    state.player.isShielding = true
  }
}

function playerIdle(state) {
  if (!state.player.isAttacking || !state.player.isShielding)
    state.player.action = "idle"
}

function playerLeft(state) {
  if (!state.player.isAttacking || !state.player.isShielding) {
    state.player.action = "run"
    state.player.dir = "left"
  }
}

function playerRight(state) {
  if (!state.player.isAttacking || !state.player.isShielding) {
    state.player.action = "run"
    state.player.dir = "right"
  }
}

function playerJump(state) {
  if (state.player.onGround && (!state.player.isAttacking || !state.player.isShiedling)) {
    state.player.velY = 500
  }
}

// dont hate me for it
// but this is the most fked up thing ive written in my entire life.
function enemyUpdate(state, { worldWidth, worldHeight, delta }) {
  const localEnemies = state.enemies

  for (const enemy of localEnemies) {
    // Enemy movement.
    if (enemy.x > state.player.x) {
      enemy.action = "walk"
      enemy.dir = "left"
      enemy.velX = -80
    }
    if (enemy.x < state.player.x) {
      enemy.action = "walk"
      enemy.dir = "right"
      enemy.velX = 80
    }

    enemy.x += enemy.velX * delta;
    enemy.y += enemy.velY * delta;
  }

  state.enemies = localEnemies
}

function spawnEnemy(state, { x, y }) {
  state.enemies = [
    ...state.enemies, {
      size: 70,

      velX: 0,
      velY: 0,

      action: "walk",
      dir: "left",

      currentFrame: 0,
      frameCount: 5,

      attackTimer: 0,
      isAttacking: false,

      x,
      y
    }
  ]
}
