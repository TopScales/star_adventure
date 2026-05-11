# Mechanics

## Ship Composition

The ships, both for player and enemies, consist of different parts, meaning, frameworks containing modules. The final stats of each ship, will be defined by the ship frameworks and the modules they contain. The base parts of a ship are:

- Hull
- Propulsion Framework
- Weapon Frameworks

Each part can have different types of modules that serve specific purposes. Ship designs made by the player are saved and are available to be used to play any level.

### Hull

The hull mainly defines the defense stats of the ship. The hardness of the hull is related to the number of hits it can receive before destroying the ship. More importantly, the shields offer another layer of defense, exclusive to the player, that has the most weight when defining a strategy. The ship is surrounded by these directional shields that cover a certain part of the ship and that are destroyed by sections. Each shield can absorb a certain number of hits before being eliminated.

### Propulsion

The propulsion system provides a way for the ship to move according to a momentum-based simulation. This forces the player to anticipate each movement, especially when using heavier ships. The different environments presented on each level will make it more suitable to use ships with different masses. Ships have two velocities, one using its full potential (maximum speed), and the second that is a fraction of the full velocity (cruising speed).

The propulsion system uses energy proportional to the force that it exerts on the ship. Once the energy is consumed, the ship can only move at cruising speed.

### Weapons

Weapons have specializations. For instance, one type of gun can be better used to destroy asteroids and debris, while other is better to pierce through enemy ships hulls.

There are two types of weapons, light and heavy weapons. Neither type use energy, but in the case of heavy weapons, they need a minimum amount of energy to work.

### Stats

The stats that define a ship's capabilities are:

- **Mass**. How hard is it to accelerate or halt the ship.
- **Shape factor**. Can create a difference on how the ship move along the `x` or `y` axis.
- **Energy**. The maximum amount of energy that the ship can store.
- **Shields**. The number of shields protecting the ship.
- **Hull Points**. The maximum number of hits the hull can receive.
- **Thrust**. The force applied to the ship to move it.
- **Power usage**. The energy that the ship uses per second at maximum speed.

## Environmental Hazards

While traveling in space, some environmental hazards will be encountered. These environmental hazards can damage the ship in some way, for both the player and the enemy, but there can be exceptions. The most common ones are asteroids and debris. Asteroids can contain resource that can be acquired by destroying it and approaching the resulting resource. Debris are mainly created when destroying certain types of enemies, but can also appear randomly floating in space.

Other environmental hazards are specific to certain levels and can be radiation damage, meteor showers, energy consumption due to heat, gravity pools.

## Levels

When the players starts a level, the ship has all its stats at the maximum. To complete a level, the player's ship need to travel a certain amount of distance. The specific time required to complete the level will depend on the thrusters used in the ship design and the usage of the maximum speed vs cruising speed. In average, levels should take from 30 to 60 seconds to complete.

Each level will have specific types of enemies that will be spawned randomly with certain probability. Also, the amount of asteroids and debris will be specified per level as a random chance to appear. The player will know in advance what type of enemies and environmental hazards are present in the levels, so they can prepare with a suitable ship design.

## Progression

As the player complete levels, it will advance through a space map denoting conquered regions. Some of these regions will have planets, otherwise they will be just empty space. In some case the progress will be branched out and multiple levels can then be chosen to play next.

## Resources

Resources are produced in planets or recollected during a level. Resources are needed to unblock modules for the ship. Using the modules to create a new ship has a small resource cost, but unblocking modules becomes increasingly expensive.