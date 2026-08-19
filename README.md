# 🎯 Arena Survivor

A 2D top-down arena survival game built with **Godot 4.6** and **GDScript**.

You control a small angry cube dropped into an open arena. Enemies spawn endlessly around you and walk straight at you. Your gun aims and fires on its own — your only job is to keep moving, stay alive, and hoover up the XP gems your kills leave behind.

> ⚠️ **Work in progress.** This is a learning project, built to get hands-on with Godot 4's node system, signals, physics layers and 2D animation.

---

## ✨ Features

- **Twin-stick-style movement** — smooth 8-directional WASD movement with walk/idle animations
- **Auto-targeting weapon** — the gun scans an `Area2D` radius, locks onto the nearest enemy and fires every 0.3s
- **Endless enemy spawning** — mobs spawn at random points along a `Path2D` ring around the arena and chase the player
- **Damage on contact** — standing inside enemies drains health continuously, and the drain scales with how many are touching you
- **XP & leveling** — dead enemies drop XP gems; collect 10 to level up, with an animated fade-out "Level Up!" message
- **Health & XP bars** — live HUD feedback for both
- **Sound effects** — shooting, XP pickup, level up and game over, handled by a global `Audio` autoload singleton
- **Game over screen** — pauses the scene tree when your health hits zero

---

## 🎮 Controls

| Action | Key |
| --- | --- |
| Move up | `W` |
| Move left | `A` |
| Move down | `S` |
| Move right | `D` |

Shooting is fully automatic — there is no fire button.

---

## 🚀 Getting started

### Requirements

- [Godot Engine **4.6**](https://godotengine.org/download) or newer (standard build — no C# / .NET needed)

### Run it

```bash
git clone https://github.com/AugustSud/Godot-Game-Arena-Survivor.git
cd Godot-Game-Arena-Survivor
```

Then:

1. Open the **Godot Project Manager**
2. Click **Import**
3. Select `test-project/project.godot`
4. Press **F5** (or the ▶ button) to play

The main scene is `scenes/game.tscn`.

> **Note:** the project is configured to use the **Forward+** renderer, and on Windows it defaults to the **Direct3D 12** rendering driver. If you're on Linux or macOS, or on older hardware, switch to **Vulkan** or the **Compatibility** renderer in *Project → Project Settings → Rendering*.

---

## 📁 Project structure

```
test-project/
├── project.godot          # Engine config, input map, physics layers
├── icon.svg
├── graphics/
│   ├── Default/           # Character parts, faces, tiles, environment
│   └── Bullet/            # Projectile sprite
├── SFX/
│   ├── shoot.mp3
│   ├── xp.mp3
│   ├── level_up.mp3
│   └── game_over.mp3
└── scenes/
    ├── game.tscn / game.gd        # Main scene: spawning, game over, level UI
    ├── player.tscn / player.gd    # Movement, health, XP, leveling
    ├── gun.tscn / gun.gd          # Auto-aim targeting + bullet spawning
    ├── bullet.tscn / bullet.gd    # Projectile travel, range limit, hit detection
    ├── enemy.tscn / enemy.gd      # Chase AI, health, XP gem drop
    ├── mob.tscn / mob.gd          # Enemy visuals + walk/hurt animations
    ├── AngryCube.tscn             # Player visuals + animations
    ├── xp.tscn / xp.gd            # Collectible XP gem
    ├── tree.tscn                  # Environment prop
    └── audio.tscn / audio.gd      # Global SFX singleton (autoloaded as `Audio`)
```

---

## 🧠 How it works

A few implementation details worth pointing out:

**Signals over polling.** The player emits `health_depleted` and `leveled_up`; the game scene listens and reacts by showing the game over screen or updating the level label. No node reaches into another node's internals to check state.

**Auto-aim via Area2D.** `gun.gd` calls `get_overlapping_bodies()` every physics frame, grabs the first enemy in range, and rotates to face it with `look_at()`. A `Timer` node drives the fire rate, so changing weapon speed is a one-property edit in the editor.

**Bullets with finite range.** Each projectile tracks distance travelled and frees itself past 1200px, so stray bullets don't leak memory. On impact it duck-types the target — `if body.has_method("take_damage")` — which means anything can be made damageable without touching bullet code.

**Deferred spawning.** XP gems are added with `add_child.call_deferred()` so nodes aren't created mid-physics-step while the enemy that dropped them is being freed.

**Scaling contact damage.** Damage is `5.0 * overlapping_mobs.size() * delta`, so getting swarmed genuinely hurts more than being cornered by one enemy.

**Physics layers.** Three named layers keep collisions clean: `Terrain`, `Player`, `Enemies`.

---

## 🗺️ Roadmap

- [ ] Level-up upgrade choices (weapon damage, fire rate, move speed, pickup radius)
- [ ] Multiple weapon types
- [ ] Enemy variety — tanky, fast and ranged enemy types
- [ ] Difficulty curve — spawn rate and enemy health scaling with time survived
- [ ] Survival timer + score, with a persistent high score
- [ ] Main menu, pause menu and restart-without-relaunching
- [ ] Web (HTML5) export so it's playable in the browser
- [ ] Rename `test-project/` to something less temporary 🙂

---

## 🙏 Credits

- Built with the [Godot Engine](https://godotengine.org/)

---

<div align="center">
Made with 🕹️ and Godot
</div>
