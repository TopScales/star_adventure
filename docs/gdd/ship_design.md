# Ship Design

## Ship Framework

The base parts of a ship are:
- Hull
- Propulsion Framework
- Weapons Framework

The propulsion and weapons decks can be combined in a single module. The combination of different ship parts define the ship configuration. Each part has the following properties:
- Material
- Deck slots
- Mass

These properties are interrelated: more deck slots, mean more mass, and the mass also depends on the material.

### Material

Each material has a density, a shield level and a prestige level. Reference values are taken from real values, but won't necessarily the final value. Density is measured in g/cm3, and the shield level is related to material stiffness given in GPa.

| Material | Density | Shield | Prestige |
|----------|---------|--------|----------|
| Steel | 8 | 200 | 0 |
| Aluminum | 3 | 70 | 2 |
| Titanium | 5 | 120 | 3 |
| Carbon Fiber | 2 | 500 | 3 |
| Lithium Alloy | 2 | 100 | 3 |
| Inconel | 8 | 200 | 4 |

### Deck slots

Each base part can have different types of decks.

The Hull can have:
- Life support
- Sensor Deck
- Communication module
- Avionics
- Cargo

The Propulsion Framework can have:
- Fuel Tanks
- Engineering Deck
- Thrusters
- Power Plant
- Navigation console

The Weapon Framework can have:
- Weapon modules
- Weapons console
- Defense system
- Shields