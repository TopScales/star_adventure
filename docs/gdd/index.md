# Game Design Document

Star Adventure – Minimal GDD (MVP)
1. High Concept

Star Adventure is a mobile shoot ’em up inspired by Space Invaders, focused on short, intense play sessions. The player pilots a spacecraft through escalating waves of enemies and environmental hazards, relying on movement, positioning, and spatial awareness rather than raw firepower.

Design Pillars:

Player skill over stats

Simple inputs, layered depth

Short sessions with high replayability

Clear, readable systems

2. Target Platform & Audience

Platform: Mobile (iOS / Android)

Orientation: Portrait

Audience: Casual–midcore action players

Session Length: 2–5 minutes

3. Core Gameplay Loop

Start a short level

Move and shoot enemies

Avoid or exploit environmental hazards

Manage positioning to protect ship shields

Complete the level or get destroyed

Advance to the next, harder level

4. Core Mechanics (MVP)
4.1 Directional Shields

The ship has directional shields (front, left, right).

Each shield can absorb one hit.

Once broken, that side becomes vulnerable.

Shields reset at the start of each level.

Design Goal: Encourage movement and positioning instead of static play.

4.2 Momentum-Based Movement

The ship has slight inertia.

Direction changes are not instantaneous.

Touch or virtual joystick controls.

Design Goal: Increase skill expression and make movement feel meaningful.

4.3 Environmental Hazards

Hazards include asteroids and moving debris.

Hazards damage both the player and enemies.

Hazard patterns are predictable and readable.

Design Goal: Add emergent challenge without increasing enemy complexity.

4.4 Short, Escalating Levels

Levels last 30–60 seconds.

Each level introduces one escalation (speed, density, or hazard variation).

Difficulty increases linearly per level.

Design Goal: Fit mobile play habits and support rapid iteration.

5. Player Controls

Move: Drag or virtual joystick

Shoot: Automatic forward firing

Design Principle: One-hand playable, no button overload.

6. Enemies (MVP Scope)

Basic Enemy Ship

Moves in simple patterns

Fires slow, readable projectiles

Enemy variety comes from positioning and hazards, not behaviors.

7. Failure & Progression

Player loses when the ship is hit without an active shield.

Progression is level-based within a single run.

No meta-progression in MVP.

8. Visual & UX Direction

Clear silhouettes and high contrast

Minimal UI during gameplay

Strong visual feedback for:

Shield breaks

Collisions

Level completion

9. MVP Success Criteria

Players understand movement and shields within the first 10 seconds.

Runs feel challenging but fair.

Players voluntarily replay after failure.

10. Out of Scope (Post-MVP)

Resource systems

Special abilities

Persistent upgrades

Advanced enemy behaviors

These will be considered only after MVP validation.