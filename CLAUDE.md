# witchy-run - CLAUDE.md

## 1. Overview / Resumo
**[PT-BR]** Projeto de jogo de plataforma 2D Endless Runner desenvolvido na engine **Godot Engine 4** utilizando a linguagem GDScript. O jogo implementa física de corpo rígido com `CharacterBody2D`, pulo duplo, colisões por `Area2D`, coleta de moedas e controle de respawn de inimigos via `Timer`.

---

## 2. Technical Stack
- **Engine**: Godot Engine 4.x
- **Language**: GDScript (Godot Scripting Language)
- **Nodes & Components**:
  - `CharacterBody2D` (Player e Inimigos)
  - `AnimatedSprite2D` (Animações de sprite)
  - `Area2D` & `CollisionShape2D` (Coletáveis e triggers)
  - `Timer` (Gestão de respawn assíncrono)

---

## 3. Key Scripts & Architecture

### Player Controller (`Scripts/player.gd`)
- Herda de `CharacterBody2D`.
- Controla vetor `velocity` com movimento horizontal `SPEED = 200.0` e pulo `JUMP_VELOCITY = 400.0`.
- Suporte a duplo pulo controlado pela flag booleana `can_double_jump`.
- Método `recebe_dano()` com controle de invencibilidade temporária e recarga de cena (`get_tree().reload_current_scene()`).

### Enemy Behavior (`Scripts/gotinha.gd`)
- Movimento progressivo para a esquerda no eixo X (`position.x -= SPEED * delta`).
- Respawn aleatório via `Timer` (`randi_range(5, 15)` segundos) quando a coordenada ultrapassa o limite da tela (`END_X = -100`).
